import 'package:equatable/equatable.dart';

import '../model/user.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}
class UserStateError extends UserState{}

class UserStateSuccess extends UserState {
  User information ; 
  UserStateSuccess({
    required this.information,
  });
}
