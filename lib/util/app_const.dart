class AppConsts {
  //static const String baseUrl = 'http://103.110.218.55:1045/api/';
  static const String baseUrl = 'http://192.168.0.249:1045/api/';
  static const double baseLongitude = 90.3601855;
  static const double baseLatitude = 23.8166277;
  // double baseLongitude = 90.3601855;
  // double baseLatitude = 23.8166277;

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}
