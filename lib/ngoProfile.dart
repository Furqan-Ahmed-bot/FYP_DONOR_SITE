// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, camel_case_types, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';
import 'package:dashboard_final/cart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './headingWidget.dart';
import 'models/donationsModel.dart';
import 'models/ngoModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NGOProfile extends StatefulWidget {
  final donorId;
  int ngoId;
  final desc;
  final name;
  final cell;
  final fow;
  final image;
  NGOProfile(this.donorId, this.ngoId, this.desc, this.name, this.cell,
      this.fow, this.image);
  @override
  _NGOProfileState createState() => _NGOProfileState();
}

List<Donations> donation = [];

class _NGOProfileState extends State<NGOProfile> {
  @override
  int photoIndex = 0;

  List<String> photos = ['assets/default.png'];
  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HeadingWidget(widget.name),
          Stack(
            children: <Widget>[
              widget.image == "abcd"
                  ? Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                              image: AssetImage(photos[photoIndex]),
                              fit: BoxFit.fill)),
                      height: MediaQuery.of(context).size.height * 0.3,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                              image: MemoryImage(base64Decode(widget.image)),
                              fit: BoxFit.fill)),
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
              Positioned(
                top: 190.0,
                left: 25.0,
                right: 25.0,
                child: SelectedPhoto(photos.length, photoIndex),
              ),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                onTap: _nextImage,
              ),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
                onTap: _previousImage,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Description',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.32,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  text: widget.desc,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                openwhatsapp(widget.cell);
              },
              child: Icon(Icons.chat_rounded),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartApp(
                                widget.donorId, widget.ngoId, widget.fow)),
                      );
                    },
                    child: Text(
                      'Donate now!',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
          ),
        ],
      ),
    );
  }

  openwhatsapp(String cell) async {
    var whatsappURl_android = "whatsapp://send?phone=" + cell + "&text=";
    var whatappURL_ios = "https://wa.me/$cell?text=${Uri.parse("")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp not installed")));
      }
    }
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto(this.numberOfDots, this.photoIndex);

  Widget _inactivePhoto() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
      ),
    ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 1.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }

  Future<List<Ngos>> fetchNGOs(http.Client client, String fow) async {
    var data = {'field_of_work': fow};
    final response = await client.post(
        Uri.parse('https://edonations.000webhostapp.com/api-ngo.php'),
        body: jsonEncode(data));
    // Use the compute function to run parseNgos in a separate isolate.
    return compute(parseNgos, response.body);
  }

// A function that converts a response body into a List<Ngos>.
  List<Ngos> parseNgos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ngos>((json) => Ngos.fromJson(json)).toList();
  }
}
