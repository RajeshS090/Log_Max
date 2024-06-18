part of 'profile_update_bloc.dart';

@immutable
abstract class ProfileUpdateEvent {}

class ProfileUpdate extends ProfileUpdateEvent {
  final String txtId;
  final String txtName;
  final String txtEmail;

  ProfileUpdate({
    required this.txtId,
    required this.txtName,
    required this.txtEmail,
  });
}
