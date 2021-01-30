import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/fishnamemodel.dart';

class ControllerRepo {
  Future<bool> sendControl(FishNameRequestModel obj, String url) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(url,
        body: json.encode(obj.toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});

    if (result.statusCode == 401) {
      return false;
    } else if (result.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }
}
