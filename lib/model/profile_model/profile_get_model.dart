class ProfileModel {
  String id;
  String userId;
  String userRole;
  String walletBalance;
  String textName;
  String textEmail;
  String textMobile;
  List<dynamic> listAddress;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.userRole,
    required this.walletBalance,
    required this.textName,
    required this.textEmail,
    required this.textMobile,
    required this.listAddress,
  });

  // Define a factory method to parse JSON into a ProfileModel object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      userId: json['user_id'],
      userRole: json['user_role'],
      walletBalance: json['wallet_balance'],
      textName: json['text_name'],
      textEmail: json['text_email'],
      textMobile: json['text_mobile'],
      listAddress: json['List_Address'],
    );
  }
}
