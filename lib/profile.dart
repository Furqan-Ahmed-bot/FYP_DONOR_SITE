// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, unused_label, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:typed_data';
import 'donor_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  final username;
  final address;
  final contact;
  final email1;
  final image;
  final donoId;
  final password;

  const EditProfile(this.address, this.username, this.contact, this.email1,
      this.image, this.donoId, this.password);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String localmage = '';
  TextEditingController usernamee = TextEditingController();
  TextEditingController contactt = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController image = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localmage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Stack(
                  children: [
                    localmage.isNotEmpty
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                MemoryImage(base64Decode(localmage)),
                          )
                        : const CircleAvatar(
                            radius: 50,
                          ),
                    InkWell(
                      onTap: () {
                        chooseImage();
                      },
                      child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Color(0xFFFF7643),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(children: [
                  
                  SizedBox(
                  height: 45,
                ),
                buildTextField("Full Name", widget.username, false, usernamee),
                SizedBox(
                  height: 25,
                ),
                buildTextField("Address", widget.address, false, addresss),
                SizedBox(
                  height: 25,
                ),
                buildTextField("Contact", widget.contact, true, contactt),
                SizedBox(
                  height: 40,
                ),
                ],),
              ),
            
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      updatedata();
                    },
                    color: Color(0xFFFF7643),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonorAppBar(
                                  widget.donoId,
                                  widget.address,
                                  widget.username,
                                  widget.contact,
                                  widget.email1,
                                  widget.password,
                                  image.text)));
                      // updatedata();
                    },
                    color: Color(0xFFFF7643),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController ctrl) {
    return TextField(
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xFFFF7643),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      controller: ctrl,
    );
  }

  Future updatedata() async {
    String url = 'https://edonations.000webhostapp.com/api-updatedonor.php';
    var data = {
      'username': usernamee.text == "" ? widget.username : usernamee.text,
      'address': addresss.text == "" ? widget.address : addresss.text,
      'contact': contactt.text == "" ? widget.contact : contactt.text,
      'email': widget.email1,
      'image': localmage
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg['status'] == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile not updated!')));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                widget.donoId,
                addresss.text == "" ? widget.address : addresss.text,
                usernamee.text == "" ? widget.username : usernamee.text,
                contactt.text == "" ? widget.contact : contactt.text,
                widget.email1,
                widget.password,
                localmage == "" ? widget.image : localmage)));

                               Fluttertoast.showToast(
        msg: "Profile Updated",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFFFF7643),
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
    } else {
      SnackBar(content: Text('Not Registered!'));
    }
  }

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != null)
      image:
      localmage;
  }

  Future LoginUser() async {
    String url = 'https://edonations.000webhostapp.com/api-login.php';
    var data = {
      'email': widget.email1,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                msg[0]['user_id'],
                msg[0]['address'],
                msg[0]['username'],
                msg[0]['contact'],
                msg[0]['email'],
                msg[0]['password'],
                msg[0]['image'])));
      }
    } else {
      SnackBar(content: Text('Invalid Username or Password!'));
    }
  }

  Future<String> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imagePicker =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (_imagePicker != null) {
      Uint8List bytes = await _imagePicker.readAsBytes();

      String encode = base64Encode(bytes);

      return encode;
    } else {
      if (kDebugMode) {
        print('Pick Image First');
      }
      return 'Error';
    }
  }
}
