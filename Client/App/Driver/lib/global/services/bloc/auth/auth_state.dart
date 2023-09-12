class AuthState {
  final bool isLoading;
  AuthState({
    required this.isLoading,
  });
}

class AuthInitial extends AuthState {
  AuthInitial({
    required super.isLoading,
  });
}

class AuthLoggedInState extends AuthState {
  AuthLoggedInState({
    required super.isLoading,
  });
}

class AuthRegisteredState extends AuthState {
  AuthRegisteredState({
    required super.isLoading,
  });
}

class AuthLoggedOutState extends AuthState {
  AuthLoggedOutState({
    required super.isLoading,
  });
}
