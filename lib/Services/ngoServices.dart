// ignore_for_file: file_names, deprecated_member_use, prefer_collection_literals, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/ngoModel.dart';

class NGOData {
  static const String url = 'https://edonations.000webhostapp.com/api-ngo.php';

//   Future<List<Ngos>> fetchNgos() async {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var ngos = Ngos.fromJson(jsonDecode(response.body));
//       return ngos as Future<List<Ngos>>;
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }

  // Future<Ngos> fetchNgos() async {
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Ngos.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Ngos');
  //   }
  // }
  Future<List<Ngos>> fetchNgos(http.Client client) async {
    final response = await client.get(Uri.parse(url));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseNgos, response.body);
  }

// A function that converts a response body into a List<Photo>.
  List<Ngos> parseNgos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Ngos>((json) => Ngos.fromJson(json)).toList();
  }
}
