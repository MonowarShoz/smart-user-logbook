class UserAddModel {
  String? name;
  String? firebaseDivToken;
  double? longitude;
  double? latitude;
  String? timeOfCreate;
  String? designation;
  String? userImage;
  UserAddModel({
    this.name,
    this.firebaseDivToken,
    this.longitude,
    this.latitude,
    this.timeOfCreate,
    this.designation,
    this.userImage,
  });

  UserAddModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firebaseDivToken = json['firebaseDivToken'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    timeOfCreate = json['timeOfCreate'];
    designation = json['designation'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['firebaseDivToken'] = this.firebaseDivToken;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['timeOfCreate'] = this.timeOfCreate;
    data['designation'] = this.designation;
    data['userImage'] = this.userImage;
    return data;
  }
}
