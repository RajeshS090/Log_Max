part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginData;

  LoginSuccess({required this.loginData});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
