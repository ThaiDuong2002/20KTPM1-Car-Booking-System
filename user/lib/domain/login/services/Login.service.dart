import '../../base/base_failure.dart';
import '../../base/base_result.dart';
import '../../../data/login/remote/dto/login_request.dart';
import '../../../data/login/respository/login.respository.dart';
import '../entity/login_entity.dart';

class LoginService {
  final LoginRepository loginRepository;

  LoginService({required this.loginRepository});

  Future<BaseResult<LoginEntity, Failure>> login(
      LoginRequest loginRequest) async {
    return await loginRepository.login(loginRequest);
  }
}
