import 'package:driver/global/services/bloc/auth/auth_event.dart';
import 'package:driver/global/services/bloc/auth/auth_state.dart';
import 'package:driver/global/services/general/auth/auth_provider.dart';
import 'package:driver/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(AuthInitial(
          isLoading: true,
        )) {
    on<AuthInitialEvent>(
      (event, emit) async {
        emit(AuthInitial(isLoading: true));
        await secureStorage.read(key: 'userId').then((value) {
          if (value != null) {
            emit(AuthLoggedInState(isLoading: false));
          } else {
            emit(AuthInitial(
              isLoading: false,
            ));
          }
        });
      },
    );

    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthInitial(isLoading: true));
        final user = provider.logIn(
          identifier: event.identifier,
          password: event.password,
        );
        // ignore: unnecessary_null_comparison
        if (user != null) {
          emit(AuthLoggedInState(isLoading: false));
        } else {
          emit(AuthInitial(isLoading: false));
        }
      },
    );

    on<AuthRegisterEvent>(
      (event, emit) {
        emit(AuthRegisteredState(isLoading: false));
      },
    );

    on<AuthLogoutEvent>(
      (event, emit) async {
        emit(AuthInitial(isLoading: true));
        await provider.logOut();
        emit(AuthInitial(isLoading: false));
      },
    );
  }
}
