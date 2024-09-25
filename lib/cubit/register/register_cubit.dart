import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sikshya/services/api_services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService _apiService;
  RegisterCubit(this._apiService)
      : super(const RegisterState(
          status: RegisterStatus.initial,
          errorMessage: null,
        ));

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String role,
    required String phoneNumber,
    required String address,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final response = await _apiService.postRequest('register/', {
        'username': username,
        'email': email,
        'password': password,
        'role': role,
        'phone_number': phoneNumber,
        'address': address,
      });

      if (response.statusCode == 200) {
        emit(state.copyWith(status: RegisterStatus.successful));
      } else {
        emit(state.copyWith(
            status: RegisterStatus.error,
            errorMessage: 'Something went wrong'));
      }
    } on SocketException {
      emit(state.copyWith(
          status: RegisterStatus.error,
          errorMessage: 'No internet Connection'));
    } catch (e) {
      emit(state.copyWith(
          status: RegisterStatus.error, errorMessage: e.toString()));
    }
  }
}
