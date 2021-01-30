import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/tankidmodel.dart';

class TankIdRepo {
  Future<List<String>> tankIds(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(GETTANKIDSURL,
        body: json.encode(RequestTankIdsModel(email).toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});

    if (result.statusCode != 200) {
      return null;
    }

    prefs.setString("token", result.headers['authorization']);

    final response = ResponseTankIdsModel.fromJson(json.decode(result.body.toString()));
    return response.tankIds;
    //   List<String> idarray = [
    //   "1000000",
    //   "1111111",
    //   "102546600",
    //   "3200001111",
    //   "1000000",
    //   "1111111",
    //   "102546600",
    //   "3200001111",
    //   "1000000",
    //   "1111111",
    //   "102546600",
    //   "3200001111",
    //   "1000000",
    //   "1111111",
    //   "102546600",
    //   "3200001111"
    // ];
    // return idarray;
  }
}
