import 'package:flutter/cupertino.dart';

class GraphRequestModel {
  final String email;
  final String device_id;
  final String day;

  GraphRequestModel(
      {@required this.email, @required this.device_id, @required this.day});

  Map<String, dynamic> toMap() {
    return {"email": email, "device_id": device_id, "day": day};
  }
}

class GraphResponseModel {
  final List<TimeSeriesPh> phlist;
  final List<TimeSeriesTemp> templist;

  GraphResponseModel({this.phlist, this.templist});

  factory GraphResponseModel.fromJson(Map<String, dynamic> json) {
    List<TimeSeriesPh> phlist = [];
    List<TimeSeriesTemp> templist = [];

    if (json['data'].length == 0) {
      return GraphResponseModel(phlist: [], templist: []);
    }

    json['data'].forEach((data) {
      print(data);
      phlist.add(TimeSeriesPh(DateTime.parse(data[0]), double.parse(data[1])));
      templist.add(TimeSeriesTemp(DateTime.parse(data[0]), double.parse(data[2])));
    });

    return GraphResponseModel(phlist: phlist, templist: templist);
  }
}

class TimeSeriesPh {
  final DateTime time;
  final double ph;

  TimeSeriesPh(this.time, this.ph);
}

class TimeSeriesTemp {
  final DateTime time;
  final double temp;

  TimeSeriesTemp(this.time, this.temp);
}
