class LoginModel {
  String? userId;
  String? userType;

  LoginModel({
    this.userId,
    this.userType,
  });

  LoginModel copyWith({
    String? userId,
    String? userType,
  }) =>
      LoginModel(
        userId: userId ?? this.userId,
        userType: userType ?? this.userType,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['userid'],
      userType: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userId,
      'user_type': userType,
    };
  }
}