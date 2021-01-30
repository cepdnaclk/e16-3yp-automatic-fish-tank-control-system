class SignupRequestModel {
  String fname;
  String lname;
  String email;
  String password;

  SignupRequestModel(this.fname, this.lname, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'password':password
    };
  }
}

class SignupResponseModel {
  bool status;

  SignupResponseModel(this.status);

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(json['status']);
  }
}
