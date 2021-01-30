import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/graphmodel.dart';
import '../constants.dart';

class GraphRepo {
  Future<GraphResponseModel> getphGraph(String day, String email, String deviceid) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await http.post(GRAPHURL,
        body: json.encode(GraphRequestModel(email: email, device_id: deviceid, day: day).toMap()),
        headers: {HttpHeaders.authorizationHeader: prefs.getString("token")});

    if (result.statusCode == 401) {
      return null;
    } else if (result.statusCode == 200) {
      return GraphResponseModel.fromJson(jsonDecode(result.body));
    } else {
      throw Exception();
    }
  }
}
