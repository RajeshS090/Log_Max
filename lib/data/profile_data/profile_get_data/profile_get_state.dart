import '../../../model/profile_model/profile_get_model.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  final ProfileModel userProfile;

  UserProfileSuccess({required this.userProfile});
}

class UserProfileError extends UserProfileState {
  final String errorMessage;

  UserProfileError({required this.errorMessage});
}

