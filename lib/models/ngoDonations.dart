// To parse this JSON data, do
//
//     final ngoDonations = ngoDonationsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<NgoDonations> ngoDonationsFromJson(String str) => List<NgoDonations>.from(
    json.decode(str).map((x) => NgoDonations.fromJson(x)));

String ngoDonationsToJson(List<NgoDonations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NgoDonations {
  NgoDonations(
      {required this.username,
      required this.name,
      required this.quantity,
      required this.date,
      required this.donation_id});

  String username;
  String name;
  String quantity;
  String date;
  String donation_id;

  factory NgoDonations.fromJson(Map<String, dynamic> json) => NgoDonations(
        username: json["username"],
        name: json["name"],
        quantity: json["quantity"],
        date: json["date"],
        donation_id: json["donation_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "quantity": quantity,
        "date": date,
        "donation_id": donation_id,
      };
}
