import 'package:flutter/cupertino.dart';

class AddTankRequestModel {
  final String email;
  final String device_id;
  final List<String> fish_names;
  final List<int> fish_count;
  final int height;
  final int lenght;
  final int width;

  AddTankRequestModel(
      {@required this.email,
      @required this.device_id,
      @required this.fish_names,
      @required this.fish_count,
      @required this.height,
      @required this.lenght,
      @required this.width});
}


