import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logmax/data/profile_data/profile_get_data/profile_get_event.dart';
import 'package:logmax/data/profile_data/profile_get_data/profile_get_state.dart';
import 'package:meta/meta.dart';

import '../../../model/profile_model/profile_get_model.dart';

class ProfileGetBloc extends Bloc<UserProfileEvent, UserProfileState> {
  ProfileGetBloc() : super(UserProfileInitial()) {
    on<FetchUserProfile>(fetchUserProfile);
  }

  Future<void> fetchUserProfile(
      FetchUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());

    try {
      final response = await Dio().get(
        'https://www.logmax.in/api/user_profile.php',
        queryParameters: {
          'user_id': event.userId,
        },
      );

      final profileData = response.data['profile_data'];
      print(profileData);

      emit(UserProfileSuccess(
          userProfile: ProfileModel.fromJson(profileData)));
    } catch (e) {
      emit(UserProfileError(errorMessage: e.toString()));
    }
  }
}
