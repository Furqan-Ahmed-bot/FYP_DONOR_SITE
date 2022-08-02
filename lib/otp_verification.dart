// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dashboard_final/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Otp extends StatefulWidget {
  Otp(this.data);
  final data;
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<void> signInWithPhoneAuthCred(
      AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verified! Now you can login')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  Future sendotp() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+92${widget.data['contact']}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            // currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
            this.verificationID = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
  }

  Future register() async {
    String url = 'https://edonations.000webhostapp.com/api-signup.php';
    var data = {
      "username": widget.data['username'].toString(),
      "email": widget.data['email'].toString(),
      "password": widget.data['password'].toString(),
      "address": widget.data['address'].toString(),
      "contact": widget.data['contact'].toString(),
      "image": "abcd"
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (msg[0]['status'] == false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Not Registred')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registred successfully')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendotp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/illustration-3.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: "Enter Your OTP"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            AuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationID,
                                    smsCode: otpController.text);
                            signInWithPhoneAuthCred(phoneAuthCredential)
                                .then((value) {
                              register();
                              Fluttertoast.showToast(
                                  msg:
                                      "Account Verified !! /n Please Login Now",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Color(0xFFFF7643),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          },
                          child: Text("Verify")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Didn't you receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    sendotp();
                  },
                  child: Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF7643),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _textFieldOTP({bool? first, last}) {
  //   return Container(
  //     height: 65,
  //     child: AspectRatio(
  //       aspectRatio: 1.0,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: (value) {
  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                 width: 2,
  //                 color: Color(0xFFFF7643),
  //               ),
  //               borderRadius: BorderRadius.circular(12)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                 width: 2,
  //                 color: Color(0xFFFF7643),
  //               ),
  //               borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}


// import 'package:dashboard_final/welcomepage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';




// enum LoginScreen{
//   SHOW_MOBILE_ENTER_WIDGET,
//   SHOW_OTP_FORM_WIDGET
// }
// class Otp extends StatefulWidget {
//   const Otp({Key? key}) : super(key: key);

//   @override
//   OtpState createState() => OtpState();
// }

// class OtpState extends State<Otp> {
// TextEditingController  phoneController = TextEditingController();
// TextEditingController  otpController = TextEditingController();
// LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
// FirebaseAuth _auth = FirebaseAuth.instance;
// String verificationID = "";

// void SignOutME() async{
//   await _auth.signOut();
// }
// void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async
// {

//   try {
//     final authCred = await _auth.signInWithCredential(phoneAuthCredential);

//     if(authCred.user != null)
//     {

//       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Welcome()));
//     }
//   } on FirebaseAuthException catch (e) {

//     print(e.message);
//     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Some Error Occured. Try Again Later')));
//   }
// }


// showMobilePhoneWidget(context){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Spacer(),
//       Text("Verify Your Phone Number" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//       SizedBox(height: 7,),
//       SizedBox(height: 20,),
//       Center(
//         child:       TextField(

//           controller: phoneController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12) ),
//               hintText: "Enter Your PhoneNumber"
//           ),
//         ),
//       ),
//       SizedBox(height: 20,),
//       // ElevatedButton(onPressed: ()  async{
//       //   await _auth.verifyPhoneNumber(

//       //       phoneNumber: "+92${phoneController.text}",
//       //       verificationCompleted: (phoneAuthCredential) async{


//       //       },
//       //       verificationFailed: (verificationFailed){
//       //         print(verificationFailed);
//       //       },

//       //       codeSent: (verificationID, resendingToken) async{
//       //         setState(() {

//       //           currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
//       //           this.verificationID = verificationID;
//       //         });
//       //       },
//       //       codeAutoRetrievalTimeout: (verificationID) async{

//       //       }
//       //   );
//       // }, child: Text("Send OTP")),
//       SizedBox(height: 16,),
//       Spacer()
//     ],
//   );
// }


// showOtpFormWidget(context){
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Spacer(),
//       // ignore: prefer_const_constructors
//       Text("ENTER YOUR OTP" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//       SizedBox(height: 7,),
//       SizedBox(height: 20,),
//       Center(
//         child: TextField(

//           controller: otpController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12) ),
//               hintText: "Enter Your OTP"
//           ),
//         ),
//       ),
//       SizedBox(height: 20,),
//       ElevatedButton(onPressed: () {

//         AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
//         signInWithPhoneAuthCred(phoneAuthCredential);
//       }, child: Text("Verify")),
//       SizedBox(height: 16,),
//       Spacer()
//     ],
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET ? showMobilePhoneWidget(context) : showOtpFormWidget(context),
//     );
//   }
// }