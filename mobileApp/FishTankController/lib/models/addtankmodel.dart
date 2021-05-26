import 'package:flutter/cupertino.dart';

class AddTankRequestModel {
  final String phone_no;
  final String email;
  final String device_id;
  final List<String> fish_names;
  final List<int> fish_count;
  final int height;
  final int lenght;
  final int width;

  AddTankRequestModel({
      @required this.phone_no,
      @required this.email,
      @required this.device_id,
      @required this.fish_names,
      @required this.fish_count,
      @required this.height,
      @required this.lenght,
      @required this.width});

  Map<String, dynamic> toMap() {
    return {
      "phone_no":phone_no,
      "email": email,
      "device_id": device_id,
      "fish_names": fish_names,
      "fish_count": fish_count,
      "height": height,
      "lenght": lenght,
      "width": width
    };
  }
}
