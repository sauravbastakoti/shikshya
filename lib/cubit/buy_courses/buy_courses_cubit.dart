import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sikshya/services/api_services.dart';

part 'buy_courses_state.dart';

class BuyCoursesCubit extends Cubit<BuyCoursesState> {
  final ApiService _apiService;
  BuyCoursesCubit(this._apiService)
      : super(const BuyCoursesState(
            status: BuyCoursesStatus.initial, errorMessage: null));

  Future<void> checkUser(
    int course,
  ) async {
    emit(state.copyWith(status: BuyCoursesStatus.loading));
    try {
      final response = await _apiService.postRequest('courses/book/', {
        'course': course,
      });

      print(response.data);
      if (response.statusCode == 201) {
        emit(state.copyWith(status: BuyCoursesStatus.success));
      } else {
        emit(state.copyWith(
          status: BuyCoursesStatus.error,
        ));
      }
    } on SocketException {
      emit(state.copyWith(
          status: BuyCoursesStatus.error,
          errorMessage: 'No Internet Connection'));
    } catch (e) {
      emit(state.copyWith(
          status: BuyCoursesStatus.error, errorMessage: e.toString()));
    }
  }
}
