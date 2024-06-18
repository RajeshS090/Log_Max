import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../model/profile_model/profile_update_model.dart';

part 'profile_update_event.dart';
part 'profile_update_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc() : super(ProfileUpdateInitial()) {
    on<ProfileUpdate>(_profileUpdateEvent);
  }

  Future<void> _profileUpdateEvent(ProfileUpdate event, Emitter<ProfileUpdateState> emit) async {
    emit(ProfileUpdateLoading());
    try {
      final dio = Dio();
      final response = await dio.put(
        'https://www.logmax.in/api/update_profile.php',
        data: {
          "txtId": event.txtId,
          "txtName": event.txtName,
          "txtEmail": event.txtEmail,
        },
      );

      if (response.data['status']) {
        emit(ProfileUpdateSuccess(message: response.data['message']));
      } else {
        emit(ProfileUpdateError(errorMessage: 'Update failed.'));
      }
    } catch (e) {
      emit(ProfileUpdateError(errorMessage: e.toString()));
    }
  }
}
