// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:dashboard_final/Login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  
  final currentPassword;
  final email;
  final donorId;
  ChangePassword(this.donorId, this.currentPassword, this.email);
  

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}



TextEditingController currentpassword = TextEditingController();
TextEditingController newPass = TextEditingController();
TextEditingController repass = TextEditingController();

 clearText() {
    currentpassword.clear();
    newPass.clear();
    repass.clear();
    
  }
  
  


class _ChangePasswordState extends State<ChangePassword> {

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: 300,
          child: Column(
            children: [
              Text('Change Password' , style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: currentpassword,
                decoration: InputDecoration(
                  hintText: "Current Password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: true,
                controller: newPass,
                decoration: InputDecoration(hintText: "New Password"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: repass,
                obscureText: true,
                decoration: InputDecoration(hintText: " Re enter New Password"),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: 
                // ElevatedButton(
                //   color: Color(0xFFFF7643),
                //   child: Text("Update" , style: TextStyle(color: Colors.white),),
                //   onPressed: () {
                    
                //     changePass();
                //     clearText();
                    
                //   },
                  
                // ),
                ElevatedButton(child: Text("Update" , style: TextStyle(color: Colors.blue),),
                onPressed: (){
                  changePass();
                  clearText();
                },)
              ),
              
              // Text(widget.email),
            ],
            
          ),
        ),
      )),
    );
  }

  Future changePass() async {
    String url = 'https://edonations.000webhostapp.com/api-changePassword.php';
    var data = {'email': widget.email, 'password': newPass.text};
    //var msg = jsonDecode(result.body);
    if (widget.currentPassword == currentpassword.text) {
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (result.statusCode == 200) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
             Fluttertoast.showToast(
        msg: "Password Changed!!\n Please Login with New Password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFFFF7643),
        textColor: Colors.white,
        fontSize: 16.0
    );
      } else if
        (currentpassword.text != repass.text){
           Fluttertoast.showToast(
        msg: "new password and re-entered new password isn't match",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFFFF7643),
        textColor: Colors.white,
        fontSize: 16.0
    );
        }
        

          
      
      else{
         Fluttertoast.showToast(
        msg: "Current Password is incorrect",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFFFF7643),
        textColor: Colors.white,
        fontSize: 16.0
    );

      }
    }
  }
}
