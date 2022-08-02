// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dashboard_final/Login.dart';
import 'package:dashboard_final/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold( 
      body: SingleChildScrollView(
        child: Column(children: [
           Padding(
             padding: const EdgeInsets.only(top: 50),
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Welcome to E-Donation" ,
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                   SizedBox(height: size.height * 0.06),
                   SvgPicture.asset(
                       "assets/chat.svg",
                       height: size.height * 0.45,
                     ),
                     SizedBox(height: 50,),
                   Padding(
                   padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                   child: Container(
                     height: 50,
                     width: 300,
                     child: RaisedButton(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(28),
                       ),
                       color: Color(0xFFFF7643),
                       child: Text(
                         'Login',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       onPressed: () {
                          Navigator.push(context,
                               MaterialPageRoute(builder: (context) => Login()));
                         // _firebaseMessaging.subscribeToTopic('registeruser');
                        
                       },
                     ),
                   ),
                 ), 
                 SizedBox(height: 20,),
                  Padding(
                   padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                   child: Container(
                     height: 50,
                     width: 300,
                     child: RaisedButton(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(28),
                       ),
                       color: Color(0xFFFF7643),
                       child: Text(
                         'SignUp',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           
                         ),
                       ),
                       onPressed: () {
                        Navigator.push(context,
                               MaterialPageRoute(builder: (context) => SignUp()));
                         // _firebaseMessaging.subscribeToTopic('registeruser');
                        
                       },
                     ),
                   ),
                 ), 
                 ]
                 
                 ),
             ),
           ),
        ],),
      )
      
         
       );
   
  }
}