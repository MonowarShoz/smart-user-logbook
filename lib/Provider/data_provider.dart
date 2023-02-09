import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../model/response_model.dart';
import '../model/update_token_model.dart';
import '../model/user_add_model.dart';
import '../model/user_model.dart';
import '../repository/data_repo.dart';
import '../responseApi/api_response.dart';

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

  Future<ResponseModel> loginUser({String? user}) async {
    _userModel = UserModel();
    _isLoading = true;

    ApiResponse apiResponse = await dataRepo.loginUser(username: user);
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

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await launchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  sendNotification(String title, String token, String name, String latitude, String longitude) async {
    final data = {
      'id': '1',
      'status': 'done',
      'message': '$latitude$longitude',
    };
    try {
      http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAywDtows:APA91bEgpC4Zu5hgijoy0MnzxY5B1eFbiUHuLxI-Y7b-Ra4XdgUUBvJ2yrRPocOA6M3YFaKNo5aZ2v4X2pCy2MAuI8zTfp48MJYVq6Oc5S4FscS30sSkY3NLr6z8mTmCqbd7KmC5hZq9'
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'title': title,
                'body': 'You are notified by $name,He is in this Location Latitude:$latitude......Longitude:$longitude'
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