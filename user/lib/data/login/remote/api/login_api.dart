import '../../../../domain/login/entity/login_entity.dart';
import '../dto/login_request.dart';

abstract class LoginApi {
  Future<LoginEntity> login(LoginRequest loginRequest);
}
  // Future<BaseResult<LoginEntity, BaseException>> login(LoginRequest loginRequest);
