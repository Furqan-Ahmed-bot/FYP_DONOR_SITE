// ignore_for_file: prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:convert';
import 'package:dashboard_final/donor_appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  
  String? token1;
  bool ShowCircle = true;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      print("Token is" + token!);

      setState(() {
        token1 = token;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    firebaseCloudMessaging_Listeners();
  }

  @override
  int flag = 0;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  void vaildation() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both Fleid Is Empty"),
        ),
      );
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Not Vaild"),
        ),
      );
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Too Short"),
        ),
      );
    } else {
      LoginUser();
    }
  }

  Widget build(BuildContext context) {
    int flag = 0;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          // color: Colors.blue[800],
                          color: Color(0xFFFF7643),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          // color: Colors.blue[800],
                          color: Color(0xFFFF7643),
                          fontSize: 25,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.5,
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
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                      
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter Your Email",
                            
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
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                            TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Your Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                             child: Icon(Icons.password  ,),),
                            contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.black),
                            gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 10,)
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: Color(0xFFFF7643),
                      // ignore: prefer_const_constructors
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        ShowCircle = !ShowCircle;
                        if (ShowCircle)
                          CircularProgressIndicator(value: 0.0);
                        else
                          CircularProgressIndicator(value: 1.0);

                        vaildation();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont Have Acccount?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text('SignUp' , style: TextStyle(color: Color(0xFFFF7643),),)),
                  ],
                ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text('Forgot Password?' , style: TextStyle(color: Color(0xFFFF7643),),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future LoginUser() async {
    int flag = 0;
    String url = 'https://edonations.000webhostapp.com/api-login.php';
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg.length <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect Email or Password!')));
      } else {

        updatefcm();

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('user_id', msg[0]['user_id']);
        preferences.setString('email', emailController.text);
        preferences.setString('address', msg[0]['address']);
        preferences.setString('username', msg[0]['username']);
        preferences.setString('contact', msg[0]['contact']);
        preferences.setString('password', msg[0]['password']);
        preferences.setString('image', msg[0]['image']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                int.parse(msg[0]['user_id']),
                msg[0]['address'],
                msg[0]['username'],
                msg[0]['contact'],
                msg[0]['email'],
                msg[0]['password'],
                msg[0]['image'])));
      }
    }
  }

   Future updatefcm() async {
    String url = 'https://edonations.000webhostapp.com/api-update-fcm.php';
    var data = {
      'email': emailController.text,
      'fcm': token1,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg['status'] != false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You logged in as ${emailController.text}')));
      }
    }
  }
}
