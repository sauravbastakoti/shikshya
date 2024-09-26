part of 'buy_courses_cubit.dart';

enum BuyCoursesStatus {
  initial,
  loading,
  success,
  error,
}

class BuyCoursesState extends Equatable {
  final BuyCoursesStatus status;

  final String? errorMessage;

  const BuyCoursesState({required this.status, required this.errorMessage});

  BuyCoursesState copyWith({
    BuyCoursesStatus? status,
    String? errorMessage,
  }) {
    return BuyCoursesState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
