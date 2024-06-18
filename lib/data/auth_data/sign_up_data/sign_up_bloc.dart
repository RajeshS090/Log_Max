import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../model/auth_model/sign_up_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(signUpEvent);
  }

  Future<void> signUpEvent(SignUpInitialEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://www.logmax.in/api/register_user.php',
        data: {
          "txtMobile": event.signMobile,
          "txtPassword": event.signUpPassword,
          "txtName": event.signUpName,
          "txtEmail": event.signUpEmail,
        },
      );
      print(response.data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        emit(SignUpSuccess(SignUpModel(
          txtMobile: event.signMobile,
          txtPassword: event.signUpPassword,
          txtName: event.signUpName,
          txtEmail: event.signUpEmail,
        )));

      } else {
        emit(SignUpFailure(response.data['message'] ?? 'Registration Failed'));
      }
    } catch (e) {
      emit(SignUpFailure('Error: $e'));
    }
  }
}
