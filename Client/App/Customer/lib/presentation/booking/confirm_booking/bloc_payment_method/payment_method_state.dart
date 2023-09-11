import 'package:equatable/equatable.dart';
import 'package:user/presentation/booking/confirm_booking/model/payment_method.dart';

class PaymentMethodState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaymentMethodInitial extends PaymentMethodState {}

class PaymentMethodLoading extends PaymentMethodState {}

class PaymentMethodSuccess extends PaymentMethodState {
  List<PaymentMethod> data;
  PaymentMethodSuccess({
    required this.data,
  });
}
