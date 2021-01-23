import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/loginmodel.dart';
import '../constants.dart';

class LoginRepo {
  Future<String> login(LoginRequestModel obj) async {
    final result = await http.post(LOGINURL, body: jsonEncode(obj));
    if (result.statusCode != 200) {
      return '';
    }
    final loginresponse = LoginResponseModel.fromJson(jsonDecode(result.body));
    if (loginresponse.status = true) {
      return result.headers['Authorization'];
    } else {
      return '';
    }
  }
}
