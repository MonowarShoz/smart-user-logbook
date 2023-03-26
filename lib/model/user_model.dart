class UserModel {
  String? id;
  String? name;
  String? password;
  String? firebaseDivToken;
  num? longitude;
  num? latitude;
  String? dateTime;
  String? designation;
  String? userImage;
  String? strImg;

  UserModel(
      {this.id, this.name, this.password, this.firebaseDivToken, this.longitude, this.latitude, this.dateTime, this.userImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    firebaseDivToken = json['firebaseDivToken'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    dateTime = json['dateTime'];
    designation = json['designation'];
    userImage = json['userImage'];
    strImg = json['strImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['firebaseDivToken'] = this.firebaseDivToken;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['dateTime'] = this.dateTime;
    data['designation'] = this.designation;
    data['userImage'] = this.userImage;
    data['strImg'] = this.strImg;

    return data;
  }
}
