class FishNameRequestModel {
  final String device_id;
  FishNameRequestModel(this.device_id);

  Map<String, dynamic> toMap() {
    return {"device_id": device_id};
  }
}

class FishNameResponseModel {
  final List<String> fishnames;
  final List<int> fishcounts;

  FishNameResponseModel({this.fishcounts, this.fishnames});

  factory FishNameResponseModel.fromJson(Map<String, dynamic> json) {
    return FishNameResponseModel(
        fishnames: List<String>.from(json['fish names'].map((x) => x)),
        fishcounts: List<int>.from(json['fish counts'].map((x) => x)));
  }
}
