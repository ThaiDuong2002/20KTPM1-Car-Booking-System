import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.message, required this.code});

  @override
  List<Object?> get props => [];
}

class BaseFailure extends Failure {
  @override
  final int code;
  @override
  final String message;

  const BaseFailure({required this.message, required this.code})
      : super(message: message, code: code);
}
