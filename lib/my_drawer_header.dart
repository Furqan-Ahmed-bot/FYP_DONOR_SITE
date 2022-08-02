// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  final username;
  final email;
  final image;

  MyHeaderDrawer(this.username, this.email, this.image);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  String localmage = '';
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localmage = widget.image;
  }
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFF7643),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           localmage.isNotEmpty
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(base64Decode(localmage)),
                )
              : const CircleAvatar(
                  radius: 50,
                ),
          Text(
            widget.username,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.email,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
