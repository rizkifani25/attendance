class LoginLecturerRequest {
  String lecturerEmail;
  String password;

  LoginLecturerRequest({this.lecturerEmail, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lecturer_email'] = this.lecturerEmail;
    data['password'] = this.password;
    return data;
  }

  factory LoginLecturerRequest.fromJson(Map<String, dynamic> json) {
    return LoginLecturerRequest(
      lecturerEmail: json['lecturer_email'],
      password: json['password'],
    );
  }
}
