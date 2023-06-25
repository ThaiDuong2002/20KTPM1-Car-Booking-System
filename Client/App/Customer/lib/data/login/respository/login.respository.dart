import '../../../domain/login/entity/login_entity.dart';
import '../../../domain/base/base_exception.dart';
import '../../../domain/base/base_failure.dart';
import '../../../domain/base/base_result.dart';
import '../remote/api/login_api.dart';
import '../remote/dto/login_request.dart';

class LoginRepository  {
  final LoginApi loginApi;

  LoginRepository({required this.loginApi});

  Future<BaseResult<LoginEntity, Failure>> login(LoginRequest loginRequest) async {
    try {
      var result = await loginApi.login(loginRequest);
      return BaseResult.success(result);
    } on BaseException catch (e) {
      return BaseResult.error(BaseFailure(message: e.message, code: e.code!));
    }
  }
}

