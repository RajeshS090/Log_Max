import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logmax/model/auth_model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(loginUserEvent);
  }

  Future<void> loginUserEvent(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://www.logmax.in/api/login_auth.php',
        data: {
          'login_user': event.loginUser,
          'login_pass': event.loginPass,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        print('responseData: $responseData');

        final bool status = responseData['status'] ?? false;
        final String message = responseData['message'] ?? 'Unknown error occurred';
        print('Login response: $responseData');

        if (status) {
          final loginData = responseData['login_data'];
          print('Login data: $loginData');

          // Convert loginData to LoginModel
          final loginModel = LoginModel.fromJson(loginData);

          // Save login details to shared_preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', loginModel.userId ?? '');
          await prefs.setString('userType', loginModel.userType ?? '');

          emit(LoginSuccess(loginData: loginModel));
        } else {
          emit(LoginError(error: message));
          print('Login error: $message');
        }
      } else {
        emit(LoginError(error: 'Failed to login. Please try again later.'));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error: ${e.response!.data}');
        emit(LoginError(error: 'Failed to login. Please try again later.'));
      } else {
        // Network error
        emit(LoginError(error: 'Network error. Please check your internet connection.'));
      }
    } catch (e) {
      // Handle other unexpected errors
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      emit(LoginError(error: 'An unexpected error occurred.'));
    }
  }
}
