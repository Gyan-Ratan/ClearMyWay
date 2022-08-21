import 'dart:async';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_mao/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(26.8504, 75.6395);
  static const LatLng destination = LatLng(26.9035, 75.7293);

  List<LatLng> polylineCoordinates =[];
  LocationData? currentLocation;
void getCurrentLocation() {
  Location location =Location();

  location.getLocation().then(
      (location) {
        currentLocation =location;
      },
  );
  location.onLocationChanged.listen(
          (newLoc) {
            currentLocation=newLoc;

            setState(() {});
          },);
}

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
  getCurrentLocation();
    getPolyPoints();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clear My Way",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body:
      currentLocation == null ? const Center(child: Text("Loading Data")) :
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!
          ),
          zoom: 12.5,
        ),
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: primaryColor,
            width: 6,
          ),
        },
        markers: {
          Marker(markerId: const MarkerId("currentLocation"),
          position: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!
            )
          ),

          const Marker(markerId: MarkerId("source"),
          position: sourceLocation,
          ),
          const Marker(markerId: MarkerId("destination"),
            position: destination
            ,
          ),
        },


      ),
    );
  }
}
