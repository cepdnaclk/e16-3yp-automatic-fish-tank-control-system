class ResponseTankIdsModel {
  final List<String> tankids;

  ResponseTankIdsModel(this.tankids);

  List<String> get tankIds => this.tankids;

  factory ResponseTankIdsModel.fromJson(Map<String, dynamic> json) {
    return ResponseTankIdsModel(json["data"]);
  }
}

class RequestTankIdsModel{
  final String email;

  RequestTankIdsModel(this.email);
}
