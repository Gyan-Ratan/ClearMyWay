import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

<<<<<<< HEAD
  List<LatLng> polylineCoordinates =[];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        // GOOGLE_API_KEY = "${GOOGLE_API_KEY},
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
            LatLng(point.latitude,point.longitude),
          );
        setState(() {});
      }}
  }
  @override
  void initState(){
    getPolyPoints();
    super.initState();
  }
||||||| 2ed7981... Added Polylines
  List<LatLng> polylineCoordinates =[];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
            LatLng(point.latitude,point.longitude),
          );
        setState(() {});
      }}
  }
  @override
  void initState(){
    getPolyPoints();
    super.initState();
  }
=======
>>>>>>> parent of 2ed7981... Added Polylines


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clear My Way",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 12.5,
        ),
      ),
    );
  }
}
