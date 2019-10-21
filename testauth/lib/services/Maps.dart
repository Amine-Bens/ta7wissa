import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testauth/ProfileScreen.dart';

class MyMap extends StatefulWidget {
  longlat longlatt;

  MyMap(this.longlatt);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {


  initState() {
    setState(() {
      allmarker.add(Marker(
        markerId: MarkerId('mmm'),
        position: LatLng(widget.longlatt.long, widget.longlatt.lat),
      ));


    });
  }

  List<Marker> allmarker = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.longlatt.long, widget.longlatt.lat),
              zoom: 12.0),
          markers: Set.from(allmarker),
        ),
      ),
    );
  }

}
