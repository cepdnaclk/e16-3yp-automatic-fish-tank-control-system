import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/loginmodel.dart';
import '../constants.dart';

class LoginRepo {
  LoginResponseModel loginresponse;

  Future<String> login(LoginRequestModel obj) async {
    final result = await http.post(LOGINURL, body: json.encode(obj.toMap()));
    if (result.statusCode != 200) {
      return '';
    }
    this.loginresponse = LoginResponseModel.fromJson(jsonDecode(result.body));
    return result.headers['authorization'];
  }
  
  LoginResponseModel get loginResponse{
    return this.loginresponse;
  }
}
