class ProfileUpdateModel {
  bool? status;
  String? message;

  ProfileUpdateModel({
    this.status,
    this.message,
  });

  ProfileUpdateModel copyWith({
    bool? status,
    String? message,
  }) =>
      ProfileUpdateModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );
}
