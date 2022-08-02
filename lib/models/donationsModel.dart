// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Donations> donationsFromJson(String str) =>
    List<Donations>.from(json.decode(str).map((x) => Donations.fromJson(x)));

String donationsToJson(List<Donations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donations {
  Donations({
    required this.ngoName,
    required this.donationId,
    required this.name,
    required this.quantity,
    required this.date,
    required this.image
  });

  String ngoName;
  String donationId;
  String name;
  String quantity;
  String date;
  String image;

  factory Donations.fromJson(Map<String, dynamic> json) => Donations(
        ngoName: json["ngo_name"],
        donationId: json["donationId"],
        name: json["name"],
        quantity: json["quantity"],
        date: json["date"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "ngoName": ngoName,
        "donationId": donationId,
        "name": name,
        "quantity": quantity,
        "date": date,
        "image": image,
      };
}
