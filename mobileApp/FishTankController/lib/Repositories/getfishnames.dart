import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/fishnamemodel.dart';

class GetFishNameRepo {
  Future<FishNameResponseModel> findFishNames(FishNameRequestModel obj) async {
    sleep(new Duration(seconds: 10));
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(GETFISHNAMES,
        body: json.encode(obj.toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});

    if (result.statusCode == 401) {
      return null;
    } else if (result.statusCode == 200) {
      return FishNameResponseModel.fromJson(jsonDecode(result.body));
    } else {
      throw Exception();
    }
  }
}
