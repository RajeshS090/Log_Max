part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpInitialEvent extends SignUpEvent {
  final String signMobile;
  final String signUpPassword;
  final String signUpName;
  final String signUpEmail;
  SignUpInitialEvent({
    required this.signMobile,
    required this.signUpPassword,
    required this.signUpName,
    required this.signUpEmail,
  });

}
