class LoginRequestModel {
  String email;
  String passord;
  LoginRequestModel({this.email,this.passord});
}

class LoginResponseModel {
  String fname;
  String lname;
  String email;

  LoginResponseModel(this.fname,this.lname,this.email);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(json["data"]["fname"],json["data"]["lname"],json["data"]["email"]);
  }

  
}
