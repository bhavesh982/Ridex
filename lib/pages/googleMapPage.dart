// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:login/global/global_var.dart';
// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({super.key});
//
//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }
//
// class _GoogleMapPageState extends State<GoogleMapPage> {
//   final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
//   GoogleMapController? contollerGoogleMap;
//
//   void UpdateMapTheme(GoogleMapController controller){
//     getJsonFileFromTheme("assets/themes/dark_theme.json").then((value)=>setGoogleMapStyle(value,controller));
//   }
//   Future<String>getJsonFileFromTheme(String mapStylePath)async{
//     ByteData byteData =await rootBundle.load(mapStylePath);
//     var list =byteData.buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes);
//     return utf8.decode(list);
//   }
//   setGoogleMapStyle(String googleMapType ,GoogleMapController controller){
//       controller.setMapStyle(googleMapType);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Ridex"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.normal,
//             myLocationEnabled: true,
//             initialCameraPosition: googlePlex,
//             onMapCreated: (GoogleMapController mapController){
//                 contollerGoogleMap=mapController;
//                 UpdateMapTheme(contollerGoogleMap!);
//                 googleMapCompleterController.complete(contollerGoogleMap);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
