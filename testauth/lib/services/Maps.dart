import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class myMap extends StatefulWidget {
  @override
  _myMapState createState() => _myMapState();
}

class _myMapState extends State<myMap> {
  final Set<Marker> markers ={};
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
//    final appState = Provider.of<AppState>(context);
//    return appState.initialPosition == null
    return Stack(
      children: <Widget>[
        GoogleMap(
          markers:_addmarker(),
          initialCameraPosition:
              CameraPosition(target: LatLng(36.903951,4.081294 ), zoom: 8.0),
          onMapCreated: _onMapcreated,
          myLocationEnabled: true,
          mapType: MapType.normal,
          compassEnabled: true,
        ),

        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
//            child: TextField(
//              cursorColor: Colors.black,
//              controller: appState.locationController,
//              decoration: InputDecoration(
//                icon: Container(
//                  margin: EdgeInsets.only(left: 20, top: 5),
//                  width: 10,
//                  height: 10,
//                  child: Icon(
//                    Icons.location_on,
//                    color: Colors.black,
//                  ),
//                ),
//                hintText: "pick up",
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//              ),
//            ),
          ),
        ),

        Positioned(
          top: 105.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
//            child: TextField(
//              cursorColor: Colors.black,
//              controller: appState.destinationController,
//              textInputAction: TextInputAction.go,
//              onSubmitted: (value) {
//                appState.sendRequest(value);
//              },
//              decoration: InputDecoration(
//                icon: Container(
//                  margin: EdgeInsets.only(left: 20, top: 5),
//                  width: 10,
//                  height: 10,
//                  child: Icon(
//                    Icons.local_taxi,
//                    color: Colors.black,
//                  ),
//                ),
//                hintText: "destination?",
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//              ),
//            ),
          ),
        ),

//        Positioned(
//          top: 40,
//          right: 10,
//          child: FloatingActionButton(onPressed: _onAddMarkerPressed,
//          tooltip: "aadd marker",
//          backgroundColor: black,
//          child: Icon(Icons.add_location, color: white,),
//          ),
//        )
      ],
    );
    ;
  }

  void _onMapcreated(GoogleMapController controller) {
    mapController = controller;
  }

  _addmarker() {
    markers.add(Marker(position: LatLng(36.903951,4.081294), markerId:null ));
  }
}
