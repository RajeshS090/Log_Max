part of 'profile_update_bloc.dart';

@immutable
abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {
  final String message;

  ProfileUpdateSuccess({required this.message});
}

class ProfileUpdateError extends ProfileUpdateState {
  final String errorMessage;

  ProfileUpdateError({required this.errorMessage});
}
