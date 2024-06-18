abstract class UserProfileEvent {}

class FetchUserProfile extends UserProfileEvent {
  final String userId;

  FetchUserProfile({required this.userId});
}

