import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:provider/provider.dart';

import '../../Provider/data_provider.dart';
import '../../Provider/location_provider.dart';

class EmployeeLocationScreen extends StatefulWidget {
  const EmployeeLocationScreen({super.key});

  @override
  State<EmployeeLocationScreen> createState() => _EmployeeLocationScreenState();
}

class _EmployeeLocationScreenState extends State<EmployeeLocationScreen> {
  late List<Marker> markers;
  final PopupController _popupController = PopupController();
  late int pointIndex;
  // List<LatLng> points = [
  //   LatLng(23.817506, 90.358846),
  //   LatLng(23.817016, 90.357183),
  //   LatLng(23.815987, 90.356014),
  //   LatLng(23.814968, 90.356058),
  //   LatLng(23.814482, 90.356110),
  //   LatLng(23.813805, 90.356242),
  // ];
  getLoc() async {
    await Provider.of<LocationProvider>(context, listen: false).getLoc();
  }

  @override
  void initState() {
    pointIndex = 0;

    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: Provider.of<LocationProvider>(context, listen: false).points[pointIndex],
        //  point: points[pointIndex],
        builder: (ctx) => const Icon(Icons.pin_drop),
      ),
    ];
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(53.3498, -6.2603),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(53.3488, -6.2613),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(53.3488, -6.2613),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(48.8566, 2.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // Marker(
    //   anchorPos: AnchorPos.align(AnchorAlign.center),
    //   height: 30,
    //   width: 30,
    //   point: LatLng(49.8566, 3.3522),
    //   builder: (ctx) => const Icon(Icons.pin_drop),
    // ),
    // ];

    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).getAllUserList();
    Provider.of<LocationProvider>(context, listen: false).liveLocation();
    return Consumer<LocationProvider>(builder: (context, lp, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pointIndex++;
            if (pointIndex >= lp.points.length) {
              pointIndex = 0;
            }
            setState(() {
              markers[0] = Marker(
                point: lp.points[pointIndex],
                //point: points[pointIndex],
                anchorPos: AnchorPos.align(AnchorAlign.center),
                height: 30,
                width: 30,
                builder: (ctx) => const Icon(Icons.pin_drop),
              );
              markers = List.from(markers);
            });
            debugPrint('important data ${lp.points}');
          },
          child: const Icon(Icons.refresh),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: lp.points[0],
            //center: points[0],
            zoom: 5,
            maxZoom: 15,
            onTap: (_, __) => _popupController.hideAllPopups(), // Hide popup when the map is tapped.
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                spiderfyCircleRadius: 80,
                spiderfySpiralDistanceMultiplier: 2,
                circleSpiralSwitchover: 12,
                maxClusterRadius: 120,
                rotate: true,
                size: const Size(40, 40),
                anchor: AnchorPos.align(AnchorAlign.center),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                  maxZoom: 15,
                ),
                markers: markers,
                polygonOptions: const PolygonOptions(borderColor: Colors.blueAccent, color: Colors.black12, borderStrokeWidth: 3),
                popupOptions: PopupOptions(
                    popupState: PopupState(),
                    popupSnap: PopupSnap.markerTop,
                    popupController: _popupController,
                    popupBuilder: (_, marker) => Container(
                          width: 200,
                          height: 100,
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => debugPrint('Popup tap!'),
                            child: Text(
                              'Container popup for marker at ${marker.point}',
                            ),
                          ),
                        )),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
