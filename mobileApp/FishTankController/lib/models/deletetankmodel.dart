class DeleteTankRequestModel {
  String email;
  String device_id;

  DeleteTankRequestModel({this.email,this.device_id});

  Map<String, dynamic> toMap() {

    return {
      "email": email,
      "device_id": device_id
    };
  }
}

