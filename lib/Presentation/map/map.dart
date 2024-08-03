// import 'dart:async';
// import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
//
// class map extends StatefulWidget {
//   const map({super.key});
//
//   @override
//   State<map> createState() => _mapState();
// }
//
// class _mapState extends State<map> {
//   final MapController mapController=MapController();
//   LocationData? currentLocation;
//   List<LatLng> routePoint=[];
//   List<Marker>markers=[];
//   final String orsApikey='5b3ce3597851110001cf6248d22cf7112df4491990bb5e646083f844';
//   @override
//   void initState(){
//     super.initState();
//     _getCurrentLocation();
//   }
//   Future<void> _getCurrentLocation()async{
//     var location=Location();
//     try{
//       var userLocation=await location.getLocation();
//       setState(() {
//         currentLocation=userLocation;
//         markers.add(Marker(point: LatLng(userLocation.latitude!, userLocation.longitude!),width: 80,height: 80, child: Icon(Icons.my_location),),);
//       });
//
//     }on Exception{
//       currentLocation=null;
//
//     }
//     location.onLocationChanged.listen((LocationData newLocation){
//       setState(() {
//         currentLocation=newLocation;
//       });
//     });
//   }
//   Future<void>_getRoute(LatLng destination)async{
//     if(currentLocation==null)return;
//     final start=LatLng(currentLocation!.latitude!,
//         currentLocation!.longitude!);
//     final response=await http.get(Uri.parse("https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApikey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}"));
//     if(response.statusCode==200){
//       final data =json.decode(response.body);
//       final List<dynamic>coords=data['features'][0]['geometry']['coordinates'];
//       setState(() {
//         routePoint=coords.map((coord)=>LatLng(coord[1],
//             coord[0])).toList();
//         markers.add(Marker(point: destination,height: 80,width: 80, child: Icon(Icons.location_on)));
//       });
//
//
//     }else{
//       print('failed to etch route');
//     }
//
//   }
//   void _addDestinationMarker(LatLng point){
//     setState(() {
//       markers.add(Marker(point: point,height: 80,width: 80, child:  Icon(Icons.location_on)));
//     });
//     _getRoute(point);
//   }
//
//
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(body: currentLocation==null?
//     Center(child: CircularProgressIndicator(),):
//
//     FlutterMap(
//       mapController: MapController,options: MapOptions(
//
//         initialCenter: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
//         initialZoom: 15.0,
//         onTap: (tapPosition.point)=>_addDestinationMarker(point),
//     ),
//       children: [TileLayer(urlTemplate: "https://{s}.title.openstreetmap.org/{z}/{x}/{y}.png",subdomains: [const ['a','b','c'],],),MarkerLayer(markers: markers),PolylineLayer(polylines: [Polyline(points: routePoint,strokeWidth: 4.0,color: Colors.blue),],),],
//     ),
//     floatingActionButton: FloatingActionButton(onPressed: (){
//     if(currentLocation!=null){
//     mapController.move(LatLng(currentLocation!.latitude!,currentLocation!.longitude!), 15.0);
//
//     }
//
//
//     },
//     child: Icon(Icons.my_location),
//   },),
//   );
// }