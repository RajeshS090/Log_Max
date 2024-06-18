class SignUpModel {
  String? txtMobile;
  String? txtPassword;
  String? txtName;
  String? txtEmail;

  SignUpModel({
    this.txtMobile,
    this.txtPassword,
    this.txtName,
    this.txtEmail,
  });

  // Factory constructor
  factory SignUpModel.fromMap(Map<String, String?> map) {
    return SignUpModel(
      txtMobile: map['txtMobile'],
      txtPassword: map['txtPassword'],
      txtName: map['txtName'],
      txtEmail: map['txtEmail'],
    );
  }

  SignUpModel copyWith({
    String? txtMobile,
    String? txtPassword,
    String? txtName,
    String? txtEmail,
  }) =>
      SignUpModel(
        txtMobile: txtMobile ?? this.txtMobile,
        txtPassword: txtPassword ?? this.txtPassword,
        txtName: txtName ?? this.txtName,
        txtEmail: txtEmail ?? this.txtEmail,
      );
}