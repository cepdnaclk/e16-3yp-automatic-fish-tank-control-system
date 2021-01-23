class SignupRequestModel {
  String fname;
  String lname;
  String email;
  String password;

  SignupRequestModel(this.fname, this.lname, this.email, this.password);
}

class SignupResponseModel {
  bool status;

  SignupResponseModel(this.status);

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(json['status']);
  }
}
