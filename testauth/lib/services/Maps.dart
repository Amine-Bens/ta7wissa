import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class goMap extends StatefulWidget {
  @override
  _goMapState createState() => _goMapState();
}

class _goMapState extends State<goMap> {
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _myLocation = CameraPosition(
    target: LatLng(28.0, 28.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Maps"),
        centerTitle: true,
      ),
      body:  GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: _myLocation),
    );
  }
}
