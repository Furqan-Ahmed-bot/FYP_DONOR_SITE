// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors
import 'package:flutter/material.dart';

class HeadingWidget extends StatefulWidget {
  final String heading;
  HeadingWidget(
    this.heading,
  );

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
    color: Color(0xFFFF7643),
      // margin: EdgeInsets.only(top: 5),
      child: Card(
        color: Color(0xFFFF7643),
        elevation: 0.0,
        child: Row(
          children: [
            Container(
              color: Color(0xFFFF7643),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 70,
              color: Color(0xFFFF7643),
              child: Text(
                widget.heading,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
