import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../repository/data_repo.dart';

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

  getLoc() {
    determinePosition().then((value) {
      _latitude = value.latitude;
      _longitude = value.longitude;
      _points.add(LatLng(_latitude, _longitude));

      notifyListeners();
    });
  }

  StreamSubscription<Position>? _positionStream;
  StreamSubscription<Position>? get positionStream => _positionStream;

  addpoint(double _latitude,double _longitude){
    _points.add(LatLng(_latitude, _longitude));
    notifyListeners();
  }

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
        //_points.add(LatLng(_latitude, _longitude));
        //notifyListeners();
        // _distanceBetween = Geolocator.distanceBetween(AppConsts.baseLatitude, AppConsts.baseLongitude, latitude, longitude);
        // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
        debugPrint('Longitude$longitude...Latitude$latitude');
        notifyListeners();
      }
    });
    //notifyListeners();
  }

  List<Placemark> _placemarks = [];
  List<Placemark> get placemarks => _placemarks;
  // Future<List<Placemark>> getAddress({double? lat, double? lang}) async {
  //   var list = [];
  //    List<Placemark> _addRessList = [];
  //   // if (lat == null || lang == null) {
  //   //   return null;
  //   // }
  //   _addRessList = await placemarkFromCoordinates(latitude, lang!);

  //   //notifyListeners();
  //   return _addRessList;
  // }

  Future getAddress({double? lat, double? lang}) async {
    if (lat == null || lang == null) {
      return null;
    }
    _placemarks = await placemarkFromCoordinates(latitude, lang);
    notifyListeners();
  }

  List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  List<LatLng> _points = [];
  List<LatLng> get points => _points;

  int pointIndex = 0;

  // markerCalc() {
  //   pointIndex++;
  //   if (pointIndex >= points.length) {
  //     pointIndex = 0;
  //   }

  //   markers[0] = Marker(
  //     point: points[pointIndex],
  //     anchorPos: AnchorPos.align(AnchorAlign.center),
  //     height: 30,
  //     width: 30,
  //     builder: (ctx) => const Icon(Icons.pin_drop),
  //   );
  //   markers = List.from(markers);
  //   notifyListeners();
  // }
}
