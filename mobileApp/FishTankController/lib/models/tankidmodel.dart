class ResponseTankIdsModel {
  final List<String> tankids;

  ResponseTankIdsModel(this.tankids);

  List<String> get tankIds => this.tankids;

  factory ResponseTankIdsModel.fromJson(Map<String, dynamic> json) {
    return ResponseTankIdsModel(List<String>.from(json["data"].map((x) => x)));
  }
}

class RequestTankIdsModel {
  final String email;

  RequestTankIdsModel(this.email);

  Map<String, dynamic> toMap() {
    return {"email": email};
  }
}
