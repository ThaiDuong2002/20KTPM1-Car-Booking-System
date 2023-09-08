
import '../dto/login/login_request.dart';
import '../dto/signup/signup_request.dart';

abstract class AuthenEvent{}

class AuthenEventLogin extends AuthenEvent {
  LoginRequest request;
  AuthenEventLogin({
    required this.request,
  });

}

class AuthenEventSignUp extends AuthenEvent {
  SignUpRequest request;
  AuthenEventSignUp({
    required this.request,
  });
}
