// ignore_for_file: file_names, deprecated_member_use, prefer_collection_literals, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/donorModel.dart';

class DonorData {
  String email;
  String password;
  DonorData(this.email, this.password);
  static const String url =
      'https://edonations.000webhostapp.com/api-login.php';

  Future<List<Donor>> getDonors() async {
    try {
      var data = {'email': email, 'password': password};
      var response = await http.post(Uri.parse(url), body: jsonEncode(data));
      //if (response.statusCode == 200) {
      final List<Donor> donors = donorsFromJson(response.body);
      return donors;
      //} else {
      //   return List.empty();
      // }
    } catch (e) {
      rethrow;
    }
  }
}
