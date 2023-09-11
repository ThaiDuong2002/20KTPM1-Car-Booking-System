import 'package:equatable/equatable.dart';
import 'package:user/presentation/booking/in_progress/model/promotion_model.dart';

class PromotionState extends Equatable {
  const PromotionState();

  @override
  List<Object> get props => [];
}

class PromotionStateInitial extends PromotionState {}

class PromotionStateLoading extends PromotionState {}

class PromotionStateSuccess extends PromotionState {
  List<Promotion> promotionList;
  PromotionStateSuccess({
    required this.promotionList,
  });
}

class PromotionStateFailure extends PromotionState {
  String message;
  PromotionStateFailure({
    required this.message,
  });
}
