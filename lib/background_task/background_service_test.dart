import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoart_monitoring/util/app_const.dart';

import '../model/update_token_model.dart';
import '../model/user_add_model.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      autoStartOnBoot: false,
    ),
  );
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  double? latitude;
  double? longitude;
  double? distanceBetween;
  String? successMessage;

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 20);
  String strDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  // setCountDown() {
  //   const reduceSecondsBy = 1;

  //   final seconds = myDuration.inSeconds - reduceSecondsBy;
  //   if (seconds < 0) {
  //     countdownTimer!.cancel();
  //   } else {
  //     myDuration = Duration(seconds: seconds);
  //   }
  // }

  String sec = myDuration.inSeconds.toString();

  // startTimer() {
  //   countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
  //     setCountDown();
  //   });
  // }

  // void stopTimer() {
  //   countdownTimer!.cancel();
  // }

  // resetTimer() {
  //   stopTimer();
  //
  //   myDuration = Duration(days: 2);
  // }

  // await Geolocator.openLocationSettings();

  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );
  var positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
    if (position == null) {
      debugPrint('unknown Location');
    } else {
      latitude = position.latitude;
      longitude = position.longitude;
      distanceBetween = Geolocator.distanceBetween(AppConsts.baseLatitude, AppConsts.baseLongitude, latitude!, longitude!);
      // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
      debugPrint('Longitude$longitude...Latitude$latitude');
    }
  });

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  // service.invoke(
  //   'update',
  //   {
  //     "duration": sec,
  //     // "Longitude": longitude,
  //     // "Latitude": latitude,
  //     // "Distance": distanceBetween,
  //     // "SUCCESS": successMessage
  //   },
  // );

  Timer.periodic(const Duration(seconds: 1), (_) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: "dur${strDigits(myDuration.inMinutes.remainder(60))}:${strDigits(myDuration.inSeconds.remainder(60))}",
          content: " Latitude:${latitude}, Longitude:${longitude}",
        );
      }
    }
    // setCountDown();
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("userID");
    final fibtoken = prefs.getString("firebaseToken");

    try {
      http.Response response = await http.put(Uri.parse('http://103.110.218.55:1045/api/User/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
            {"firebaseDivToken": fibtoken, "longitude": longitude, "latitude": latitude, "dateTime": DateTime.now().toString()},
          ));
      if (response.statusCode == 200) {
        successMessage = 'SUCCESSFULLY UPDATE LOCATION TO THE SERVER';
        print("User's Location ADDED successfully");
      } else {
        print("background api post call error");
      }
    } catch (e) {}

    // Provider.of<DataProvider>(context, listen: false).updateTokenLatLong(
    //     UpdateTokenModel(
    //       firebaseDivToken: token,
    //       latitude: latitude,
    //       longitude: longitude,
    //     ),
    //     id);

    service.invoke(
      'update',
      {
        //"duration": "${strDigits(myDuration.inMinutes.remainder(60))}:${strDigits(myDuration.inSeconds.remainder(60))}",
        "Longitude": longitude,
        "Latitude": latitude,
        "Distance": distanceBetween,
        "SUCCESS": successMessage
      },
    );
  });
}
