import 'dart:convert';
import 'dart:math';

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
import '../../../model_gobal/mylocation.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(SearchLocationStateInitial()) {
    on<SearchLocationEventSearch>(queryAddress);
  }

  Future<void> queryAddress(SearchLocationEventSearch event,
      Emitter<SearchLocationState> emit) async {
    // Dio dio = Dio();
    // late SearchLocationServices searchLocationServices;
    // SearchLocationApiImple searchLocationApi = SearchLocationApiImple(dio: dio);
    // // replace this with your actual api initialization
    // final mySearchLocationRepository = SearchLocationRepository(
    //     searchLocationApi:
    //         searchLocationApi); // replace this with your actual repository initialization
    // searchLocationServices =
    //     SearchLocationServices(loginRepository: mySearchLocationRepository);

    // BaseResult<List<ItemSearchEntity>, Failure> result =
    //     await searchLocationServices.search(event.query, currentLocation);
    // ;
    // if (result is Success<List<ItemSearchEntity>, Failure>) {
    //   // Lấy ra mảng từ trường data của thành công
    //   List<ItemSearchEntity> dataArray = result.data;

    //   emit(SearchLocationStateSuccess(searchEntities: dataArray));
    //   // Bây giờ bạn có thể sử dụng mảng dataArray ở đây
    //   // ...
    // } else if (result is Error<List<ItemSearchEntity>, Failure>) {
    //   // Xử lý lỗi nếu cần thiết
    //   Failure error = result.error;
    //   emit(SearchLocationStateFailure(message: error.message));
    // }
    // final fakeData = [
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    //   ItemSearchEntity(
    //       name: "Khoa Tham Vấn Hỗ Trợ Cộng Đồng Quận 3",
    //       formatted_address:
    //           "311 Đ. Nguyễn Thượng Hiền, Phường 4, Quận 3, Thành phố Hồ Chí Minh, Vietnam",
    //       lat: 10.7703911,
    //       lng: 106.681677,
    //       distance: 3.0),
    // ];

    // emit(SearchLocationStateSuccess(searchEntities: fakeData));

    try {
      emit(SearchLocationStateLoading());
      Dio dio = Dio();
      late SearchLocationServices searchLocationServices;
      SearchLocationApiImple searchLocationApi = SearchLocationApiImple(dio: dio);
      // replace this with your actual api initialization
      final mySearchLocationRepository = SearchLocationRepository(
          searchLocationApi:
              searchLocationApi); // replace this with your actual repository initialization
      searchLocationServices =
          SearchLocationServices(loginRepository: mySearchLocationRepository);

      BaseResult<List<ItemSearchEntity>, Failure> result =
          await searchLocationServices.search(event.query, event.searchLocation)
      ;
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
}
