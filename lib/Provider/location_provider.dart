import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
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

  List<Placemark> _placemarks = [];
  List<Placemark> get placeMark => _placemarks;

  getLoc() {
    determinePosition().then((value) {
      _latitude = value.latitude;
      _longitude = value.longitude;

      notifyListeners();
    });
  }

  StreamSubscription<Position>? _positionStream;
  StreamSubscription<Position>? get positionStream => _positionStream;

  liveLocation() {
    // const LocationSettings locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 0,
    // );

    _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 0,
    )).listen((Position? position) {
      if (position == null) {
      } else {
        //if (!mounted) return;

        _latitude = position.latitude;
        _longitude = position.longitude;
        //notifyListeners();
        // _distanceBetween = Geolocator.distanceBetween(AppConsts.baseLatitude, AppConsts.baseLongitude, latitude, longitude);
        // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
        debugPrint('Longitude$longitude...Latitude$latitude');
        notifyListeners();
      }
    });
    //notifyListeners();
  }
}
