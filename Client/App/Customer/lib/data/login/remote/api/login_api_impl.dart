import 'package:dio/dio.dart';
import '../../../../domain/login/entity/login_entity.dart';
import '../../../../domain/base/base_exception.dart';
import '../../../common/response/response_wrapper.dart';
import '../dto/login_request.dart';
import '../dto/login_response.dart';
import 'login_api.dart';

class LoginApiImpl implements LoginApi {
  final Dio dio;

  LoginApiImpl({required this.dio});

  @override
  Future<LoginEntity> login(LoginRequest loginRequest) async {
    try {
      final response =
          await dio.post("auth/login", data: loginRequest.toJson());
      var converted = WrappedResponse<LoginResponse>.fromJson(
          response.data, (data) => LoginResponse.fromJson(data.toString()));
      if (response.statusCode == 200) {
        return LoginEntity(
            id: converted.data!.id!,
            token: converted.data!.token!,
            email: converted.data!.email!,
            name: converted.data!.name!);
      }
      throw BaseException(
          message: converted.message, code: response.statusCode);
    } on DioException catch (e) {
      throw BaseException(message: e.message!, code: e.response?.statusCode);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }
}
