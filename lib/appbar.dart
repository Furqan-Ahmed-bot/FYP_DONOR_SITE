// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget bodyWidget;
  MyAppBar(this.bodyWidget);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new FlutterLogo(
          textColor: Colors.green,
          size: 25,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.grey,
        ),
      ),
      body: bodyWidget,
    );
  }
}
