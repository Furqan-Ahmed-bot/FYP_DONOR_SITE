//     final donors = donorsFromJson(jsonString);
// ignore_for_file: file_names

import 'dart:convert';

List<Donor> donorsFromJson(String str) =>
    List<Donor>.from(json.decode(str).map((x) => Donor.fromJson(x)));

String donorsToJson(List<Donor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donor {
  Donor({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.contact,
  });

  String userId;
  String username;
  String email;
  String password;
  String address;
  String contact;
  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "address": address,
        "contact": contact,
      };
}
