//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//const apiKey = "AIzaSyCwRZd0DBnyEAyPitV6y4OjaE-ccOPmO_k";
//
//class GoogleMapsServices{
//  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
//    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=36.754376,3.058506&key=$apiKey";
//    //https://maps.googleapis.com/maps/api/directions/json?origin=36.754376,3.058506&destination=36.697320,4.047796&key=AIzaSyBhDflq5iJrXIcKpeq0IzLQPQpOboX91lY
//    http.Response response = await http.get(url);
//    Map values = jsonDecode(response.body);
//    return values["routes"][0]["overview_polyline"]["points"];
//  }
//}