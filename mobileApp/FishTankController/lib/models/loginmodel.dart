class LoginRequestModel {
  String email;
  String passord;
  LoginRequestModel({this.email,this.passord});
}

class LoginResponseModel {
  bool status;

  LoginResponseModel(this.status);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(json["status"]);
  }
}
