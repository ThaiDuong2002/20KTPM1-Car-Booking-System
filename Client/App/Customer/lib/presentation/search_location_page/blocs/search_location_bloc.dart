import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_event.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_state.dart';

import '../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../data/common/module/network_module.dart';
import '../../../data/common/module/shared_pref_module.dart';
import '../../../data/search_location/remote/api/search_location_api_impl.dart';
import '../../../data/search_location/respository/search_location_repository.dart';
import '../../../domain/base/base_failure.dart';
import '../../../domain/base/base_result.dart';
import '../../../domain/search_location/entity/item_search_entity.dart';
import '../../../domain/search_location/services/search_location_services.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(SearchLocationStateInitial()) {
    on<SearchLocationEventSearch>(queryAddress);
    on<SearchLocationEventSearchAddList>(addtoList);
  }

  Future<void> queryAddress(SearchLocationEventSearch event,
      Emitter<SearchLocationState> emit) async {
    try {
      emit(SearchLocationStateLoading());
      Dio dio = Dio();
      late SearchLocationServices searchLocationServices;
      SearchLocationApiImple searchLocationApi =
          SearchLocationApiImple(dio: dio);
      // replace this with your actual api initialization
      final mySearchLocationRepository = SearchLocationRepository(
          searchLocationApi:
              searchLocationApi); // replace this with your actual repository initialization
      searchLocationServices =
          SearchLocationServices(loginRepository: mySearchLocationRepository);

      BaseResult<List<ItemSearchEntity>, Failure> result =
          await searchLocationServices.search(
              event.query, event.searchLocation);
      if (result is Success<List<ItemSearchEntity>, Failure>) {
        // Lấy ra mảng từ trường data của thành công
        List<ItemSearchEntity> dataArray = result.data;

        emit(SearchLocationStateSuccess(searchEntities: dataArray));
        // Bây giờ bạn có thể sử dụng mảng dataArray ở đây
        // ...
      } else if (result is Error<List<ItemSearchEntity>, Failure>) {
        // Xử lý lỗi nếu cần thiết
        Failure error = result.error;
        emit(SearchLocationStateFailure(message: error.message));
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  Future<void> addtoList(SearchLocationEventSearchAddList event,
      Emitter<SearchLocationState> emit) async {
    try {
      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule
          .provideDio()
          .post('/customer/address/save', data: {
        "name": event.item.title,
        "type": event.type,
        "formattedAddress": event.item.label,
        "coordinate": {"lat": event.item.lat, "lng": event.item.lng}
      });

      print(respone);
      emit(SearchLocationStateInitial());
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      print(data);
      await Future.delayed(Duration(seconds: 2));
    } on DioExceptionType catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
