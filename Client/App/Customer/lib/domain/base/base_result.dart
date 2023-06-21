import 'package:equatable/equatable.dart';

class BaseResult<T, U> extends Equatable {
  const BaseResult();

  factory BaseResult.success(T data) {
    var success = Success<T, U>(data);
    return success;
  }

  factory BaseResult.error(U err) {
    var error = Error<T, U>(err);
    return error;
  }

  @override
  List<Object?> get props => [];
}

class Success<T, U> extends BaseResult<T, U> {
  final T data;
  const Success(this.data);
}

class Error<T, U> extends BaseResult<T, U> {
  final U error;
  const Error(this.error);
}
