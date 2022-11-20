// ignore_for_file: prefer_const_constructors, unused_field, deprecated_member_use, unnecessary_new, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token1;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      print("Token is" + token!);

      setState(() {
        token1 = token;
      });
    });
  }

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  String? image1;

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);

  void vaildation() {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        username.text.isEmpty &&
        address.text.isEmpty &&
        contact.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Fleids Are Empty"),
        ),
      );
    } else if (username.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("FullName Is Empty"),
        ),
      );
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Is Not Vaild"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Is Too Short"),
        ),
      );
    } else {
      subscribe();
      // register();
      // _auth.verifyPhoneNumber(

      //     phoneNumber: "+92${contact.text}",
      //     verificationCompleted: (phoneAuthCredential) async{

      //     },
      //     verificationFailed: (verificationFailed){
      //       print(verificationFailed);
      //     },

      //     codeSent: (verificationID, resendingToken) async{
      //       setState(() {

      //         this.verificationID = verificationID;
      //       });
      //     },
      //     codeAutoRetrievalTimeout: (verificationID) async{

      //     }
      // );
       Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Otp(data)));



        Fluttertoast.showToast(
        msg: "OTP Sent to your phone",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFFFF7643),
        textColor: Colors.white,
        fontSize: 16.0
    );
    
    }
  }
  
  DateTime pre_backpress = DateTime.now();

// var data;
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        body: SafeArea( 
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                    height: 210,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SignUp',
                          style: TextStyle(
                            color: Color(0xFFFF7643),
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Create an Account',
                          style: TextStyle(
                            color: Color(0xFFFF7643),
                            fontSize: 25,
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 127,
                            width: 230,
                            child: Image(
                              image: AssetImage(
                                'assets/01.png',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 400,
                      width: 300,
                      child: Column(
                        children: [
                                 TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                            labelText: "name",
                            hintText: "Username",
                            
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                             suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                             child: Icon(Icons.email,),),
                            contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.black),
                            gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 10,)
                          ),
                            keyboardType: TextInputType.name,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]")),
                              ]
                        ),
                          
                          // mytextformfield(
                          //     'Username', 'name', username, Icon(Icons.list) , false),
                          SizedBox(height: 20),
                          mytextformfield(
                              'Email Address', 'email', email, Icon(Icons.email) , false),
                          SizedBox(height: 20),
                          mytextformfield('Password', 'password', password,
                              Icon(Icons.remove_red_eye) , true),
                          SizedBox(height: 20),
                          mytextformfield(
                              'Address', 'address', address, Icon(Icons.house) , false),
                          SizedBox(height: 20),
                          TextFormField(
                              maxLength: 11,
                              controller: contact,
                              decoration: InputDecoration(
                                labelText: "contact",
                                hintText: "Enter Your Contact ",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                               child: Icon(Icons.phone),),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: BorderSide(color: Colors.black),
                                    gapPadding: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(color: Colors.black),
                                  gapPadding: 10,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z]")),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Container(
                      height: 50,
                      width: 300,
                      child: 
                      // ElevatedButton(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(28),
                      //   ),
                      //   color: Color(0xFFFF7643),
                      //   child: Text(
                      //     'SignUp',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   onPressed: () async {
                      //     // _firebaseMessaging.subscribeToTopic('registeruser');
                          // data = await {
                          //   'username': username.text,
                          //   "email": email.text,
                          //   'password': password.text,
                          //   'address': address.text, 
                          //   'contact': contact.text,
                          //   "image": "abcd"
                          // };
    
                          // vaildation();
                         
                      //   },
                      // ),
                      ElevatedButton(
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: ()async {
                           data = await {
                            'username': username.text,
                            "email": email.text,
                            'password': password.text,
                            'address': address.text, 
                            'contact': contact.text,
                            "image": "abcd"
                          };
    
                          vaildation();
                        },
                      )
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have Acccount?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              // color: Colors.blue[800],
                              color: Color(0xFFFF7643),
                              fontSize: 15,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var data;
  TextFormField mytextformfield(
    String hint,
    String label,
    TextEditingController ctrl,
    Icon icons,
    bool flag
  ) {
    return TextFormField(
      obscureText: flag,
      controller: ctrl,
      decoration: InputDecoration(
        
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
            child: (icons),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: Colors.black),
              gapPadding: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.black),
            gapPadding: 10,
          )),
    );
  }

  Future subscribe() async {
    await _firebaseMessaging
        .subscribeToTopic("registeruser")
        .then((value) => print('User Suscribed'));
  }



 
}
