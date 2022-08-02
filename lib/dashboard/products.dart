// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dashboard_final/nearbyNgo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


import 'list.dart';


class ProductCard extends StatefulWidget {
    const ProductCard({
     Key? key,
    required this.itemIndex,
    required this.product,
    required this.fow,
    required this.donorId
    
  }) : super(key: key);

  final int itemIndex;
  final Product product;
  final String fow;
  final int donorId;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  Position? _currentUserPosition;
Future getlocation() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation().then((value) {
      setState(() {
      _currentUserPosition=value;  
      });
      
    });
  }
  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width*0.05,
        vertical: width*0.009,
      ),
      // color: Colors.blueAccent,
      height: height*0.186,
      child: InkWell(
        onTap: ()async{
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NearbyNgos(widget.donorId,widget.fow,_currentUserPosition!)));
        
          },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: height*0.135,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.05),
                color:  Colors.orange.withOpacity(0.2),
                boxShadow: [ BoxShadow(
                              offset: Offset(0, width*0.05),
                              blurRadius: width*0.05,
                              color: Colors
                                  .black12, // Black color with 12% opacity
                            ),],
              ),
              child: Container(
                margin: EdgeInsets.only(right: width*0.025),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width*0.05),
                ),
              ),
            ),
            // our product image
             Positioned(
                          top: height*0.01,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width*0.05),
                            height: height*0.15,
                            width: width*0.45,
                            child: Image.asset(
                            widget.product.image,
                              fit: BoxFit.cover,
                            ),
                          )),
            // Product title and price
              Positioned(
                          bottom: 0,
                          left: 0,
                          
                          child: SizedBox(
                            height: height*0.155,
                            width: width*0.5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05, width*0.15, width*0.05, width*0.05),
                                  child: Text(
                                    widget.product.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      // fontFamily: 'Mulish',
                                      color: Colors.grey[600]
                                      
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
          ],
        ),
      ),
    );
  }
  
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
}