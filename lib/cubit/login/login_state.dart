part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  loggedIn,
  error,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? key;
  final String? errorMessage;

  const LoginState({
    required this.status,
    required this.errorMessage,
    required this.key,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? key,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        key,
      ];
}
