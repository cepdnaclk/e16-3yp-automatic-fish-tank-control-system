class LoginRequestModel {
  String email;
  String passord;
}

class LoginResponseModel {
  bool status;

  LoginResponseModel(this.status);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(json["status"]);
  }
}
