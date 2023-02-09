class UpdateTokenModel {
  String? firebaseDivToken;
  double? longitude;
  double? latitude;
  String? dateTime;

  UpdateTokenModel({this.firebaseDivToken, this.longitude, this.latitude, this.dateTime});

  UpdateTokenModel.fromJson(Map<String, dynamic> json) {
    firebaseDivToken = json['firebaseDivToken'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firebaseDivToken'] = this.firebaseDivToken;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
