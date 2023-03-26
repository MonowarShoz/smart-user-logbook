class UpdateInfo {
  String? name;
  String? desig;
  String? strImg;

  UpdateInfo({this.name, this.desig, this.strImg});

  UpdateInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desig = json['desig'];
    strImg = json['strImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desig'] = this.desig;
    data['strImg'] = this.strImg;
    return data;
  }
}
