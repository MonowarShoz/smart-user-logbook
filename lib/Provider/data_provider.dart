import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:saver_gallery/saver_gallery.dart';
import 'package:technoart_monitoring/util/code_util.dart';
import 'package:technoart_monitoring/util/date_converter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../Models/timing_model.dart';
import '../model/Emp_att_d_model.dart';
import '../model/response_model.dart';
import '../model/update_token_model.dart';
import '../model/user_add_model.dart';
import '../model/user_model.dart';
import '../repository/data_repo.dart';
import '../responseApi/api_response.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider with ChangeNotifier {
  final DataRepo dataRepo;

  DataProvider(this.dataRepo);

  List<UserModel> _userList = [];
  List<UserModel> get userList => _userList;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getAllUserList() async {
    _userList = [];
    _isLoading = true;
    ApiResponse apiResponse = await dataRepo.getuser();
    _isLoading = false;
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _userList = [];
      apiResponse.response!.data.forEach((element) {
        _userList.add(UserModel.fromJson(element));
      });
    } else {
      debugPrint('ERROR');
    }
    notifyListeners();
  }

  List<UserModel> findOnlyUser(String id) {
    List<UserModel> userModel = [];
    userModel = userList.where((element) => element.id == id).toList();
    return userModel;
  }

  Future<ResponseModel> loginUser({required String user, required String password}) async {
    _userModel = UserModel();
    _isLoading = true;

    ApiResponse apiResponse = await dataRepo.loginUser(username: user, password: password);
    _isLoading = false;
    ResponseModel responseModel;

    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _userModel = UserModel();

      _userModel = UserModel.fromJson(apiResponse.response!.data);

      debugPrint('${userModel!.name} ${userModel!.id}');
      responseModel = ResponseModel(true, userModel!.name!);
    } else {
      responseModel = ResponseModel(false, apiResponse.error.toString());
    }
    notifyListeners();
    return responseModel;
  }

  Future addUser(UserAddModel userAddModel) async {
    _userModel = null;
    _isLoading = false;
    ApiResponse apiResponse = await dataRepo.insertUser(userAddModel);
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      _userModel = UserModel();
      // for (var element in apiResponse.response!.data) {
      //   _userModel = UserModel.fromJson(element);
      // }
    }
    notifyListeners();
  }

  Future updateUserInfo(UserAddModel userAddModel, String id) async {
    // _userModel = null;
    ApiResponse apiResponse = await dataRepo.updateInfo(userAddModel, id);
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
    } else {
      debugPrint('Failed');
    }
    notifyListeners();
  }

  logout() {
    _userModel = null;
    notifyListeners();
  }

  double _latitude = 0.0;
  double _longitude = 0.0;
  double _distanceBetween = 0.0;
  double get distanceBetween => _distanceBetween;
  double get latitude => _latitude;
  double get longitude => _longitude;

  LocationPermission? permission;

  Future<Position> determinePosition() async {
    // bool serviceEnabled;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    // await Geolocator.openAppSettings();
    // await Geolocator.openLocationSettings();
    return await Geolocator.getCurrentPosition();
  }

  getLoc() {
    determinePosition().then((value) {
      _latitude = value.latitude;
      _longitude = value.longitude;
      notifyListeners();
    });
  }

  StreamSubscription<Position>? _positionStream;
  StreamSubscription<Position>? get positionStream => _positionStream;

  // liveLocation() {
  //   // const LocationSettings locationSettings = LocationSettings(
  //   //   accuracy: LocationAccuracy.high,
  //   //   distanceFilter: 0,
  //   // );

  //   _positionStream = Geolocator.getPositionStream(
  //       locationSettings: const LocationSettings(
  //     accuracy: LocationAccuracy.best,
  //     distanceFilter: 0,
  //   )).listen((Position? position) {
  //     if (position == null) {
  //     } else {
  //       //if (!mounted) return;

  //       _latitude = position.latitude;
  //       _longitude = position.longitude;
  //       //notifyListeners();
  //       _distanceBetween = Geolocator.distanceBetween(AppConsts.baseLatitude, AppConsts.baseLongitude, latitude, longitude);
  //       // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  //       debugPrint('Longitude$longitude...Latitude$latitude');
  //       notifyListeners();
  //     }
  //   });
  //   //notifyListeners();
  // }

  Future updateTokenLatLong(UpdateTokenModel userAddModel, String id) async {
    // _userModel = null;
    _isLoading = false;
    ApiResponse apiResponse = await dataRepo.updateFbToken(userAddModel, id);
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      //_userModel = UserModel();
      // for (var element in apiResponse.response!.data) {
      //   _userModel = UserModel.fromJson(element);
      // }
    } else {
      debugPrint('Failed to Update Token');
    }
    notifyListeners();
  }

  Future<void> openMap({double? latitude, double? longitude}) async {
    const url =
        'https://www.google.com/maps/dir/?api=1&origin=23.816707361499585, 90.36026101096144&destination=23.809398876188844, 90.35731052819888&travelmode=driving&dir_action=navigate';
    // final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not open the map.';
    }
  }

  File? _selectedImg;
  File? get selectedImg => _selectedImg;

  String? _base64Img;
  String? get base64Img => _base64Img;
  Uint8List convertFromBase64(String base64string) {
    var imgbyte = base64Decode(base64string);
    return imgbyte;
  }

  convertToBase64({required File imgFile}) async {
    List<int> bytes = await imgFile.readAsBytes();
    // log(bytes.toString());
    _base64Img = base64Encode(bytes);
    log('Image string ${base64Img!.length}');
  }

  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 100,
      rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 100,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 100,
      );

      if (image == null) return;
      var bytes = await image.readAsBytes();
      //var compressedImg = testComporessList(bytes);

      final img = File(image.path);

      Directory? tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final String filePath = '$tempPath/image.jpg';
      // var compressedImg = await testCompressAndGetFile(img, filePath);

      await img.copy(filePath);
      await SaverGallery.saveImage(bytes, name: 'img', androidExistNotSave: false);
      //  _selectedImg = compressedImg;
      _selectedImg = img;

      if (selectedImg == null) return;
      convertToBase64(imgFile: selectedImg!);

      notifyListeners();
    } on PlatformException catch (e) {
      print('failed $e');
    }
  }

  decomSize(String img) {
    var str = CodeUtil.decompress(img);
    log("decompressed Length ${str.length}");

    notifyListeners();
  }

  timeFormats() {
    // var timingIsha = '06:42';

    // var hour = timingIsha.substring(0, 2);
    // var min = timingIsha.substring(3, 5);

    // TimeOfDay time = TimeOfDay(hour: int.parse(hour), minute: int.parse(min));
    //  var newTime = DateFormat("hh:mm").parse("${time.hour}:${time.minute}");
    var newTime = DateFormat("hh:mm").parse("19:42");
    var amformat = DateFormat("h:mm a").format(newTime);
    debugPrint('new time ${newTime}');
    debugPrint('new Format ${amformat}');
    notifyListeners(); // 3:00 PM
  }

  // Future<AccessToken> getAccessToken() async{
  //   final serviceAccount = await get
  // }

  sendNotification({String? title, required String token, String? name, String? latitude, String? longitude}) async {
    final data = {
      'id': '1',
      'status': 'done',
      'message': 'Hello',
    };
    try {
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAi8BbW-8:APA91bEa3eyOZrR0dU_uPzLQQTITaLscx1gRNfRNixtkS6yvnRLA6SGVKPt36ysIklL0Tgfr3vjjIwQTE1ZpkVO4PAZGKnFPnfG-eopE2wP8qp_k8eCPUl1HhYPEatCaDffyQlJ_v1hA'
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'title': "HEllo",
                'body': 'You are notified by $name,',
                'image': 'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U'
              },
              'priority': 'high',
              'data': data,
              'to': '$token'
            },
          ));
      if (response.statusCode == 200) {
        print("Yeh notificatin is sended");
      } else {
        print("Notification Operation Failed");
      }
    } catch (e) {}
    notifyListeners();
  }

  Timer? countdownTimer;
  Duration _myDuration = Duration(minutes: 1);
  Duration get myDuration => _myDuration;

  startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    notifyListeners();
  }

  setCountDown() {
    const reduceSecondsBy = 1;

    // if (myDuration.inSeconds == 0) {
    //   _myDuration.inSeconds = _myDuration.inSeconds + 1;
    // }

    final seconds = _myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      _myDuration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void stopTimer() {
    countdownTimer!.cancel();
    notifyListeners();
  }

  resetTimer() {
    stopTimer();

    _myDuration = Duration(minutes: 1);
    notifyListeners();
  }

  String strDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  DateTime chInDate = DateTime.now();
  DateTime outDate = DateTime.now().add(Duration(hours: 8));

  double toDouble(TimeOfDay myTime) {
    return myTime.hour + myTime.minute / 60.0;
  }

  int diff_hr = 0;
  int diff_mn = 0;

  timeDifference({required DateTime start}) {
    diff_hr = DateTime.now().difference(start).inHours;
    diff_mn = DateTime.now().difference(start).inMinutes.remainder(60);
    notifyListeners();
  }

  final startTime = DateTime(2020, 02, 20, 10, 30);
  final currentTime = DateTime.now();

  // final diff_dy = currentTime.difference(startTime).inDays;
  // final diff_hr = currentTime.difference(startTime).inHours;
  // final diff_mn = currentTime.difference(startTime).inMinutes;
  // final diff_sc = currentTime.difference(startTime).inSeconds;

  // print(diff_dy);
  // print(diff_hr);
  // print(diff_mn);
  // print(diff_sc);

  newTimeDifference() {}

  List<EmpattModel> _empattdList = [
    EmpattModel(
      name: 'Khaled Ahmed',
      time: '10.03 am - 7.00 pm',
      lateTime: '1 hour',
      isLate: false,
    ),
    EmpattModel(
      name: 'Kamrul Islam',
      time: '10.03 am - 7.00 pm',
      lateTime: '1 hour',
      isLate: false,
    ),
    EmpattModel(
      name: 'M Uddin',
      time: '10.03 am - 7.00 pm',
      lateTime: '1 hour',
      isLate: true,
    ),
    EmpattModel(
      name: 'M Hossain',
      time: '10.13 am - 7.00 pm',
      lateTime: '1 hour',
      isLate: true,
    ),
    EmpattModel(
      name: 'T Khan',
      time: '10.23 am - 7.00 pm',
      lateTime: '1 hour',
      isLate: false,
    ),
  ];
  List<EmpattModel> get empattDList => _empattdList;

  Timings? _timings;
  Timings? get timings => _timings;

  Future prayerTime() async {
    _timings = null;

    ApiResponse apiResponse = await dataRepo.getPrayerTime();
    if ((apiResponse.response != null) && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 200)) {
      _timings = Timings.fromJson(apiResponse.response!.data["data"]["timings"]);
    } else {}
  }

  // Duration timeDifference(DateTime inTime, DateTime outTime) {
  //   var timeDiff = outTime.difference(inTime);
  //   return timeDiff;
  // }

  // int timeDiff(TimeOfDay intime, TimeOfDay outtime) {
  //   var diff = outtime.compareTo(intime);
  //   return diff;
  // }

  // String checkedOutDate = DateConverter.formatDateIOS(DateTime.now().add(Duration(hours: 8)).toString(), isTime: true);

  // var checkedInDate = DateConverter.formatDateIOS(DateTime.now().toString());

  //var diff =

  // Future<void> uploadImageToFtp(File clickedImage) async {
  //   try {
  //     FTPConnect ftpConnect = FTPConnect(
  //       '103.110.218.55',
  //       user: 'administrator',
  //       pass: 'asit@123',
  //     );
  //     await ftpConnect.connect();
  //     await ftpConnect.changeDirectory('monowar');
  //     bool res = await ftpConnect.uploadFile(
  //       clickedImage,
  //     );

  //     if (res) {
  //       clickedImage.existsSync() ? clickedImage.delete() : '';
  //     } else {}

  //     await ftpConnect.disconnect();
  //     debugPrint('$res');
  //   } catch (e) {
  //     rethrow;
  //   }
  //   notifyListeners();
  // }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
}

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

extension TOD on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(1, 1, 1, hour, minute);
  }
}
