import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/signupmodel.dart';
import '../constants.dart';

class SignupRepo {
  Future<bool> signup(SignupRequestModel obj) async {
    final result = await http.post(SIGNUPURL, body: jsonEncode(obj));

    if (result.statusCode != 200) {
      return false;
    }
    final signupresponse =
        SignupResponseModel.fromJson(jsonDecode(result.body));
    return signupresponse.status;
  }
}
