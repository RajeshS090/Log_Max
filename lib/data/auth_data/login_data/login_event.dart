part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String loginUser;
  final String loginPass;
  LoginUserEvent({required this.loginUser, required this.loginPass});

}