import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_event.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/blocs/placeFavorite_state.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/model/address.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';

class FavoritePlaceBloc extends Bloc<PlaceFavoriteEvent, FavoritePlaceState> {
  FavoritePlaceBloc() : super(FavoritePlaceInitial()) {
    on<PlacePressUpdate>(updateLocation);
    on<PlacePressFetchData>(fetchData);
  }
  void updateLocation(PlacePressUpdate event, Emitter emit) {
    emit(FavoritePlaceLoading());
    try {
      emit(FavoritePlaceUpdateSuccess(message: "Update success"));
    } catch (e) {
      emit(FavoritePlaceUpdateFaild(message: "Update faild"));
    }
  }

  Future<void> fetchData(
      PlacePressFetchData event, Emitter<FavoritePlaceState> emit) async {
    try {
      emit(FavoritePlaceLoading());
      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule.provideDio().get('/customer/address');

      // print(vihcles);

      final address = jsonDecode(respone.toString());
      List<Address> data = [];
      address['data'].forEach((element) {
        print(element);
        final rs = Address.fromJson(element);
        data.add(rs);
      });

      print(data);
      emit(FavoritePlaceFetchData(addresses: data));
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
