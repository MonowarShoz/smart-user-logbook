class UserAddModel {
  String? name;
  String? firebaseDivToken;
  double? longitude;
  double? latitude;
  String? timeOfCreate;
  UserAddModel({this.name, this.firebaseDivToken, this.longitude, this.latitude, this.timeOfCreate});

  UserAddModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firebaseDivToken = json['firebaseDivToken'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    timeOfCreate = json['timeOfCreate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['firebaseDivToken'] = this.firebaseDivToken;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['timeOfCreate'] = this.timeOfCreate;
    return data;
  }
}
