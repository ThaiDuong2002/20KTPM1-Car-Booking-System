import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../data/search_location/remote/api/search_location_api_impl.dart';
import '../../../../data/search_location/respository/search_location_repository.dart';
import '../../../../domain/base/base_failure.dart';
import '../../../../domain/base/base_result.dart';
import '../../../../domain/search_location/entity/item_search_entity.dart';
import '../../../../domain/search_location/services/search_location_services.dart';
import 'check_address_event.dart';
import 'check_address_state.dart';

class CheckAddressBloc extends Bloc<CheckAddressEvent, CheckAddressState> {
  CheckAddressBloc() : super(CheckAddressState()){
    on<CheckAddressEventSearch>(queryAddress);
  }




  Future<void> queryAddress(
      CheckAddressEventSearch event,
      Emitter<CheckAddressState> emit) async {

    try {
      emit(CheckAddressStateLoading());
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
          await searchLocationServices.searchCheck(event.currentLocation);
      if (result is Success<List<ItemSearchEntity>, Failure>) {
        // Lấy ra mảng từ trường data của thành công
        List<ItemSearchEntity> dataArray = result.data;

        emit(CheckAddressStateSuccess(searchEntities: dataArray));
        // Bây giờ bạn có thể sử dụng mảng dataArray ở đây
        // ...
      } else if (result is Error<List<ItemSearchEntity>, Failure>) {
        // Xử lý lỗi nếu cần thiết
        Failure error = result.error;
        emit(CheckAddressStateFailure(message: error.message));
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

}
