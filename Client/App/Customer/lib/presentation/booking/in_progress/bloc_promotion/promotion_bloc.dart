import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_event.dart';
import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_state.dart';
import 'package:user/presentation/booking/in_progress/model/promotion_model.dart';

import '../../../../data/common/interceptor/authorization_interceptor.dart';
import '../../../../data/common/module/network_module.dart';
import '../../../../data/common/module/shared_pref_module.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  PromotionBloc() : super(PromotionStateInitial()) {
    on<PromotionEventFetchData>(fetchData);
  }

  Future<void> fetchData(
      PromotionEventFetchData event, Emitter<PromotionState> emit) async {
    try {
      emit(PromotionStateLoading());
      await Future.delayed(Duration(seconds: 2));

      SharedPreferenceModule pref = SharedPreferenceModule();
      RequestInterceptor requestInterceptor = RequestInterceptor();
      RequestInterceptor.pref = pref;
      NetworkModule.instance.initialize(interceptor: requestInterceptor);
      NetworkModule networkModule = NetworkModule.instance;

      final respone = await networkModule.provideDio().get('/promotions');

      // print(vihcles);

      final data_temp = jsonDecode(respone.toString());
      List<Promotion> data = [];
      data_temp['data'].forEach((item) => {
            data.add(Promotion(
                id: item['_id'],
                name: item['name'],
                description: item['name'],
                discount: item['discount'],
                startDate: item['name'],
                endDate: item['name'],
                usageLimit: 10))
          });

      emit(PromotionStateSuccess(promotionList: data));
    } on DioException catch (e) {
      final data = jsonDecode(e.response.toString());
      emit(PromotionStateLoading());

      await Future.delayed(Duration(seconds: 2));
      emit(PromotionStateFailure(message: data['message']));
    } catch (e) {
      print(e.toString());
    }
  }
}
