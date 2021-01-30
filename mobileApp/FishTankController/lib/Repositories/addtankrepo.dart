import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebar/models/addtankmodel.dart';

import '../constants.dart';

class AddTankRepo {
  Future<AddTankStatus> addTank(AddTankRequestModel obj) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(ADDTANKURL,
        body: json.encode(obj.toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});
    if (result.statusCode == 401) {
      return AddTankStatus(true, false);
    } else if (result.statusCode == 406) {
      return AddTankStatus(false, true);
    } else if (result.statusCode == 200) {
      prefs.setString("token", result.headers['authorization']);
      return AddTankStatus(false, false);
    }
    return AddTankStatus(true, true);
  }
}

class AddTankStatus {
  final bool authfail;
  final bool wrongid;

  AddTankStatus(this.authfail, this.wrongid);
}
