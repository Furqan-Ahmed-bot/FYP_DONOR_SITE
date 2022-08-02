// // ignore_for_file: file_names

// import 'dart:async';
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'headingWidget.dart';
// import 'models/ngoModel.dart';
// import 'ngoProfile.dart';

// Future<List<Ngos>> fetchNGOs(http.Client client, String fow) async {
//   var data = {'field_of_work': fow};
//   final response = await client.post(
//       Uri.parse('https://edonations.000webhostapp.com/api-ngo.php'),
//       body: jsonEncode(data));
//   // Use the compute function to run parseNgos in a separate isolate.
//   return compute(parseNgos, response.body);
// }

// // A function that converts a response body into a List<Ngos>.
// List<Ngos> parseNgos(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Ngos>((json) => Ngos.fromJson(json)).toList();
// }

// class NearbyNgos extends StatefulWidget {
//   int donorId;
//   String fow;
//   Position _currentUserPosition;
//   NearbyNgos(this.donorId, this.fow, this._currentUserPosition);
//   @override
//   State<NearbyNgos> createState() => _NearbyNgosState();
// }

// class _NearbyNgosState extends State<NearbyNgos> {
//   Future<List<Ngos>>? ngos;
//   List<Ngos>? NGO;
//   List<int>? distances;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ngos = fetchNGOs(http.Client(), widget.fow).then((value) => NGO = value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           HeadingWidget('Nearby NGOs'),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             padding: const EdgeInsets.only(left: 25, right: 25),
//             child: const Text(
//               'NGOs Around You',
//               style: TextStyle(
//                   fontFamily: 'Quicksand',
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey),
//             ),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.8,
//             margin: const EdgeInsets.only(top: 10),
//             child: FutureBuilder<List<Ngos>>(
//               future: ngos,
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return const Center(
//                     child: Text('An error has occurred!'),
//                   );
//                 } else if (snapshot.hasData) {
//                   return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                       ),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         var distance = calculateDistance(
//                             double.parse(snapshot.data![index].lat),
//                             double.parse(snapshot.data![index].lng));
//                         print('Distance is : ${distance}');
//                         int i = 0;
//                         if (distance > 0) {
//                           i++;
//                           return buildCard(
//                             snapshot.data![index].image,
//                             snapshot.data![index].ngoName,
//                             snapshot.data![index].address,
//                             snapshot.data![index].ngoId,
//                             i,
//                             snapshot.data![index].description,
//                             snapshot.data![index].contact,
//                           );
//                         } else {
//                           throw (Exception);
//                         }
//                       });
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCard(String image, String name, String address, String ngoId,
//       int cardIndex, String description, String cell) {
//     return InkWell(
//       child: Card(
//         color: Color(0xFFFF7643),
//         shadowColor: Color(0xFFFF7643),
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         elevation: 7.0,
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             Stack(children: <Widget>[
//               image == "abcd"
//                   ? Container(
//                       height: MediaQuery.of(context).size.height * 0.13,
//                       width: MediaQuery.of(context).size.width * 0.37,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.blue[800],
//                           image: const DecorationImage(
//                               image: AssetImage('assets/default.png'),
//                               fit: BoxFit.fill)),
//                     )
//                   : Container(
//                       height: MediaQuery.of(context).size.height * 0.13,
//                       width: MediaQuery.of(context).size.width * 0.37,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Colors.blue[800],
//                           image: DecorationImage(
//                               image: MemoryImage(
//                                 base64Decode(image),
//                               ),
//                               fit: BoxFit.fill)),
//                     ),
//             ]),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             FittedBox(
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                     fontFamily: 'Quicksand',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15.0,
//                     color: Colors.white),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//             FittedBox(
//               child: Text(
//                 address,
//                 style: const TextStyle(
//                     fontFamily: 'Quicksand',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.0,
//                     color: Colors.white60),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//           ],
//         ),
//         margin: cardIndex.isEven
//             ? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
//             : const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0),
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => NGOProfile(widget.donorId, int.parse(ngoId),
//                   description, name, cell, widget.fow, image)),
//         );
//       },
//     );
//   }

//   int calculateDistance(double lat, double lng) {
//     int distanceInKm;
//     int distance;
//     distanceImMeter = Geolocator.distanceBetween(
//       widget._currentUserPosition.latitude,
//       widget._currentUserPosition.longitude,
//       lat,
//       lng,
//     );
//     distance = distanceImMeter!.round().toInt();
//     distanceInKm = (distance / 1000).round().toInt();
//     return distanceInKm;
//   }
// }

// double? distanceImMeter = 0.0;
// List<Ngos> ngodata = [];


// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'headingWidget.dart';
import 'models/ngoModel.dart';
import 'ngoProfile.dart';

Future<List<Ngos>> fetchNGOs(http.Client client, String fow) async {
  var data = {'field_of_work': fow};
  final response = await client.post(
      Uri.parse('https://edonations.000webhostapp.com/api-ngo.php'),
      body: jsonEncode(data));
  // Use the compute function to run parseNgos in a separate isolate.
  return compute(parseNgos, response.body);
}

// A function that converts a response body into a List<Ngos>.
List<Ngos> parseNgos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Ngos>((json) => Ngos.fromJson(json)).toList();
}

class NearbyNgos extends StatefulWidget {
  int donorId;
  String fow;
  Position _currentUserPosition;
  NearbyNgos(this.donorId, this.fow, this._currentUserPosition);
  @override
  State<NearbyNgos> createState() => _NearbyNgosState();
}

class _NearbyNgosState extends State<NearbyNgos> {
  Future<List<Ngos>>? ngos;
  List<Ngos>? NGO;
  List<int>? distances;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ngos = fetchNGOs(http.Client(), widget.fow).then((value) => NGO = value);
  }

  @override
  Widget build(BuildContext context) {
    final padding1 = MediaQuery.of(context).size.width * 0.05;
    final padding2 = MediaQuery.of(context).size.width * 0.01;
    return Scaffold(
      body: ListView(
        children: [
          HeadingWidget('Nearby NGOs'),
          SizedBox(
            height: padding1,
          ),
          Container(
            padding: EdgeInsets.only(left: padding1, right: padding1),
            child: const Text(
              'NGOs Around You',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const Divider(),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            margin: EdgeInsets.only(top: padding2),
            child: FutureBuilder<List<Ngos>>(
              future: ngos,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return GridView.builder(
                      
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!
                          .where((product) =>
                              calculateDistance(double.parse(product.lat),
                                  double.parse(product.lng)) > 0
                              )
                          .length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard(
                                snapshot.data![index].image,
                                snapshot.data![index].ngoName,
                                snapshot.data![index].address,
                                snapshot.data![index].ngoId,
                                index,
                                snapshot.data![index].description,
                                snapshot.data![index].contact,
                                double.parse(snapshot.data![index].lat),
                                double.parse(snapshot.data![index].lng)),
                          ],
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String image, String name, String address, String ngoId,
      int cardIndex, String description, String cell, double lat, double lng) {
        var padding= MediaQuery.of(context).size.height;
        var padding2= MediaQuery.of(context).size.width;
    // var distance = calculateDistance(lat, lng);
    // print('Distance is : ${distance}');
    // if (distance > 10) {
    return InkWell(
      
      child: Card(
        color: Color(0xFFFF7643),
        shadowColor: Color(0xFFFF7643),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Stack(children: <Widget>[
              image == "abcd"
                  ? Container(
                    margin: EdgeInsets.all(padding2*0.01),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFFF7643),
                          image: const DecorationImage(
                              image: AssetImage('assets/default.png'),
                              fit: BoxFit.fill)),
                    )
                  : Container(
                    margin: EdgeInsets.all(padding2*0.01),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFFF7643),
                          image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(image),
                              ),
                              fit: BoxFit.fill)),
                    ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FittedBox(
              child: Text(
                name,
                style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            FittedBox(
              child: Text(
                address,
                style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.white60),
              ),
            ),

            FittedBox(
              child: Text(
                cell,
                style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.white60),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ],
        ),
        margin: cardIndex.isEven
            ?  EdgeInsets.fromLTRB(0, 0.0, padding2*0.01, padding2*0.01)
            :  EdgeInsets.fromLTRB(padding2*0.01, 0.0, 0, padding2*0.01),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NGOProfile(widget.donorId, int.parse(ngoId),
                  description, name, cell, widget.fow, image)),
        );
      },
    
    );
    // } else {
    //   return Stack();
    // }
  }

  int calculateDistance(double lat, double lng) {
    int distanceInKm;
    int distance;
    distanceImMeter = Geolocator.distanceBetween(
      widget._currentUserPosition.latitude,
      widget._currentUserPosition.longitude,
      lat,
      lng,
    );
    distance = distanceImMeter!.round().toInt();
    distanceInKm = (distance / 1000).round().toInt();
    return distanceInKm;
  }
}

double? distanceImMeter = 0.0;
List<Ngos> ngodata = [];

