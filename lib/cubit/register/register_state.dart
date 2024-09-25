part of 'register_cubit.dart';

enum RegisterStatus {
  //initial state
  initial,
  loading,
  successful, //successful
  error
}

class RegisterState extends Equatable {
  final RegisterStatus status;

  final String? errorMessage;

  const RegisterState({required this.status, required this.errorMessage});

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
