class UserAddModel {
  String? name;
  String? password;
  String? firebaseDivToken;
  double? longitude;
  double? latitude;
  String? timeOfCreate;
  String? designation;
  String? userImage;
  String? strImg;
  UserAddModel({
    this.name,
    this.password,
    this.firebaseDivToken,
    this.longitude,
    this.latitude,
    this.timeOfCreate,
    this.designation,
    this.userImage,
    this.strImg,
  });

  UserAddModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    firebaseDivToken = json['firebaseDivToken'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    timeOfCreate = json['timeOfCreate'];
    designation = json['designation'];
    userImage = json['userImage'];
    strImg = json['strImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['password'] = this.password;
    data['firebaseDivToken'] = this.firebaseDivToken;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['timeOfCreate'] = this.timeOfCreate;
    data['designation'] = this.designation;
    data['userImage'] = this.userImage;
    data['strImg'] = this.strImg;
    return data;
  }
}
