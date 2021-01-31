import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/deletetankmodel.dart';

class DeleteTankRepo {
  Future<bool> deleteTank(DeleteTankRequestModel obj) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(DELETETANKURL,
        body: json.encode(obj.toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});
    if (result.statusCode == 401) {
      return false;
    } else if (result.statusCode == 200) {
      prefs.setString("token", result.headers['authorization']);
      return true;
    }
    return false;
  }
}
