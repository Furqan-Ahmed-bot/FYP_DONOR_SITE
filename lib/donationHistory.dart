// // ignore_for_file: file_names

// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../Services/donationServices.dart';
// import './barchart.dart';
// import './headingWidget.dart';
// import './main.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:http/http.dart' as http;
// import 'models/donationsModel.dart';
// import 'models/ngoModel.dart';

// // ignore: must_be_immutable
// class DonartionHistory extends StatefulWidget {
//   final donorId;
//   DonartionHistory(this.donorId);
//   //DonartionHistory(this.donations);
//   @override
//   _DonartionHistoryState createState() => _DonartionHistoryState();
// }

// late TooltipBehavior _tooltipBehavior;

// class _DonartionHistoryState extends State<DonartionHistory> {
//   final List data = [];
//   @override
//   void initState() {
//     super.initState();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     //_fetchNgoName(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: ListView(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: const EdgeInsets.only(left: 25, right: 25),
//               child: const Text(
//                 'Donations History',
//                 style: TextStyle(
//                     fontFamily: 'Quicksand',
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey),
//               ),
//             ),
//             Divider(),
//             Center(
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.25,
//                 child: BarChartAPI(widget.donorId),
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.5,
//               margin: const EdgeInsets.only(top: 10),
//               child: FutureBuilder<List<Donations>>(
//                 future: fetchDonations(http.Client()),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return const Center(
//                       child: Text('An error has occurred!'),
//                     );
//                   } else if (snapshot.hasData) {
//                     return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                               margin: EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 5),
//                               elevation: 1.0,
//                               child: Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Card(
//                                       shadowColor: Colors.blue,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(0.0),
//                                       ),
//                                       color: Colors.white70,
//                                       elevation: 10,
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: snapshot
//                                                         .data![index].image ==
//                                                     "abcd"
//                                                 ? Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.28,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.28,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       image: DecorationImage(
//                                                           fit: BoxFit.fill,
//                                                           image: AssetImage(
//                                                               'assets/default.png')),
//                                                     ),
//                                                   )
//                                                 : Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.28,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.28,
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                           fit: BoxFit.fill,
//                                                           image: MemoryImage(
//                                                               base64Decode(
//                                                                   snapshot
//                                                                       .data![
//                                                                           index]
//                                                                       .image))),
//                                                     ),
//                                                   ),
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.5,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.fromLTRB(
//                                                           10, 30, 0, 0),
//                                                   child: Text(
//                                                     snapshot.data![index].name,
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 18,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.5,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.fromLTRB(
//                                                           5, 10, 0, 0),
//                                                   child: Text(
//                                                     'To ${snapshot.data![index].ngoName} on ${snapshot.data![index].date}',
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             children: <Widget>[
//                                               Padding(
//                                                 padding: EdgeInsets.fromLTRB(
//                                                     5, 40, 0, 0),
//                                                 child: Column(
//                                                   children: [
//                                                     Text(
//                                                       'Quantity',
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       snapshot.data![index]
//                                                           .quantity,
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               0.01,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ))));
//                         });
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<List<Donations>> fetchDonations(http.Client client) async {
//     const String url =
//         'https://edonations.000webhostapp.com/api-donationhistory.php';
//     var data = {'user_id': widget.donorId};

//     var result = await http.post(Uri.parse(url), body: jsonEncode(data));

//     if (result.statusCode == 200) {
//       final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
//       return parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
// }
// ignore_for_file: file_names, prefer_const_constructors, unused_import

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Services/donationServices.dart';
import './barchart.dart';
import './headingWidget.dart';
import './main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'models/donationsModel.dart';

// ignore: must_be_immutable
class DonartionHistory extends StatefulWidget {
  final donorId;
  DonartionHistory(this.donorId);
  //DonartionHistory(this.donations);
  @override
  _DonartionHistoryState createState() => _DonartionHistoryState();
}

late TooltipBehavior _tooltipBehavior;

class _DonartionHistoryState extends State<DonartionHistory> {
  final List data = [];
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    //_fetchNgoName(1);
  }

  @override
  Widget build(BuildContext context) {
    final padding1 = MediaQuery.of(context).size.width * 0.01;
    final padding2 = MediaQuery.of(context).size.width * 0.05;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: const Text(
                'Donations History',
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Divider(),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: BarChartAPI(widget.donorId),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              margin: const EdgeInsets.only(top: 10),
              child: FutureBuilder<List<Donations>>(
                future: fetchDonations(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: padding2, horizontal: padding1),
                              elevation: 1.0,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      shadowColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      color: Colors.white70,
                                      elevation: 10,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(padding1),
                                            child: snapshot
                                                        .data![index].image ==
                                                    "abcd"
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                    decoration:
                                                        const BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              'assets/default.png')),
                                                    ),
                                                  )
                                                : Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: MemoryImage(
                                                              base64Decode(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .image))),
                                                    ),
                                                  ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      padding1, padding2, 0, 0),
                                                  child: Text(
                                                    snapshot.data![index].name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      padding1, padding2, 0, 0),
                                                  child: Text(
                                                    'To ${snapshot.data![index].ngoName} on ${snapshot.data![index].date}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    padding1,
                                                    padding1 * 10,
                                                    0,
                                                    0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Quantity',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .quantity,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))));
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
      ),
    );
  }

  Future<List<Donations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/api-donationhistory.php';
    var data = {'user_id': widget.donorId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      return parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}


