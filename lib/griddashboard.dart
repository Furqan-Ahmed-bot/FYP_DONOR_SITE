
// ignore_for_file: prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard/list.dart';
import 'dashboard/products.dart';
import 'nearbyNgo.dart';

class Dashboard extends StatefulWidget {
  // final fow;
  final donorId;
  final username;
  final image;
  Dashboard(this.donorId, this.username, this.image);

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {

  Future _getLocationPermission() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      setState(() {
        PermissionStatus.granted;
      });
    } else if (await Permission.locationWhenInUse
        .request()
        .isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.locationWhenInUse.request().isDenied) {
      setState(() {
        PermissionStatus.denied;
      });
    }
  }
  String localmage = '';


  @override
  void initState() {

    super.initState();
    localmage = widget.image;
    // _getStoragePermission();
    _getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    List<String> fow=['food','clothes','books'];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Color(0xFFFF7643),
      body: Column(
        children: [

           Center(
            child: Container(
              height: height*0.16,
              width: width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width*0.1),
                    child: Text(
                        'Hello ${widget.username}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  
                  SizedBox(
                    width: width*0.2,
                  ),
                  CircleAvatar(
                    maxRadius: height*0.045,
                    child: CircleAvatar(
                      maxRadius: height*0.045,
                      backgroundImage:
                          MemoryImage(base64Decode(localmage)),
                    ),
                  ),
                ],
              ),
            ),
            
          ),
         Padding(
            padding: EdgeInsets.only(top: height*0.04),
            child: Text('Welcome To E-Donation App' , style: TextStyle(color: Colors.white , fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          
          SizedBox(
            height: height*0.05,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  
                  margin: EdgeInsets.only(top: height*0.1),
                  decoration: BoxDecoration(
                      color: Color(0xFFF1EFF1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width*0.1),
                        topRight: Radius.circular(width*0.1),
                        // bottomLeft: Radius.circular(30),
                        // bottomRight: Radius.circular(30),
                      )),
                ),  

                ListView.builder(
                  itemCount: 3,
                  
                  itemBuilder: (context, index) => ProductCard(
                    itemIndex: index,
                    product: products[index],
                    fow:fow[index],
                    donorId:widget.donorId
                  ) , ),
                

               


              

                
              ],
            ),

            
          ),

        ],
      ),
    );
  }
}
