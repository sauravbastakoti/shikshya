//main file
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sikshya/services/api_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService _apiService;
  LoginCubit(this._apiService)
      : super(const LoginState(
          status: LoginStatus.initial,
          errorMessage: null,
          key: null,
        ));

  Future<void> login(
    String email,
    String password,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    print('object');

    try {
      final response = await _apiService.postRequest(
        'login/',
        {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = response.data;
        final key = jsonBody['access'] as String;
        emit(
          state.copyWith(status: LoginStatus.loggedIn, key: key),
        );
      } else {
        emit(state.copyWith(
            status: LoginStatus.error, errorMessage: 'Something went wrong'));
      }
    } on SocketException {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: 'No Internet Connection'));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: e.toString()));
    }
  }
}
