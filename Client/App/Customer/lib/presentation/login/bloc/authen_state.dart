import 'package:equatable/equatable.dart';

class AuthenState extends Equatable{
  @override
  List<Object> get props => [];
}
class AuthenStateInitial extends AuthenState {}
class AuthenStateLoading extends AuthenState {}
class AuthenStateSuccess extends AuthenState {
  final String message;
  AuthenStateSuccess({required this.message});
  @override
  List<Object> get props => [message];
}
class AuthenStateFailure extends AuthenState {
  final String message;
  AuthenStateFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenStateLoginSucess extends AuthenState {
  final String message;
  AuthenStateLoginSucess({required this.message});
  @override
  List<Object> get props => [message];
}
