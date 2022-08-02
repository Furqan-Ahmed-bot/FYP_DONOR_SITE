// ignore_for_file: file_names, deprecated_member_use, prefer_collection_literals, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/donationsModel.dart';

class DonationData {
  static const String url =
      'https://edonations.000webhostapp.com/api-donationhistory.php';

  Future<List<Donations>> fetchDonations(http.Client client) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
