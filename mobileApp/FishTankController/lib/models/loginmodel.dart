class LoginRequestModel {
  String email;
  String password;
  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }
}

class LoginResponseModel {
  String fname;
  String lname;
  String email;

  LoginResponseModel(this.fname, this.lname, this.email);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        json["data"]["fname"], json["data"]["lname"], json["data"]["email"]);
  }
}
