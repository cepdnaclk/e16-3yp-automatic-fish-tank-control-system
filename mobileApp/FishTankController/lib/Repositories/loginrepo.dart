import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/loginmodel.dart';
import '../constants.dart';

class LoginRepo {
  LoginResponseModel loginresponse;

  Future<String> login(LoginRequestModel obj) async {
    // final result = await http.post(LOGINURL, body: jsonEncode(obj));
    // if (result.statusCode != 200) {
    //   return '';
    // }
    // this.loginresponse = LoginResponseModel.fromJson(jsonDecode(result.body));
    // return result.headers['Authorization'];
    this.loginresponse=LoginResponseModel("fname", "lname", "myemail@.com");
   return 'token';
  }
  
  LoginResponseModel get loginResponse{
    return this.loginresponse;
  }
}
