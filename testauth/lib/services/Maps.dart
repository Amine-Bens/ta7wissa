import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:testauth/ProfileScreen.dart';
import 'package:geolocator/geolocator.dart';

class goMap extends StatefulWidget {
  final longlat longetlatf;

  goMap( {Key key,this.longetlatf}):super (key : key);


  @override
  _goMapState createState() => _goMapState();
}


class _goMapState extends State<goMap> {
  bool isfull=false;

  void initState() {
    super.initState();
    setState(() {
      Geolocator().placemarkFromCoordinates(
          widget.longetlatf.long, widget.longetlatf.lat);
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Go Here !!!"),
          centerTitle: true,
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
//            Marker( visible: true,position: LatLng(widget.longetlatf.long, widget.longetlatf.lat),);
                ;
          },
          myLocationButtonEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: _initcamera(),
        ));
  }

  _initcamera() {
    if (widget.longetlatf.long != null && widget.longetlatf.lat != null) {
      return CameraPosition(zoom: 8.0,
          target: LatLng(widget.longetlatf.long, widget.longetlatf.lat));
    }
    else {}
  }
}