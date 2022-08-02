// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:convert';
import 'dart:typed_data';
import 'package:dashboard_final/models/clothesCartModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './headingWidget.dart';

class ConfirmClothesDonation extends StatefulWidget {
  int donorId;
  int ngoId;
  final ValueSetter<ClothesModel> _valueSetter;

  ConfirmClothesDonation(this.donorId, this.ngoId, this._valueSetter);
  @override
  State<ConfirmClothesDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmClothesDonation> {
  String localmage = '';

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

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != null)
      image:
      localmage;
  }

  formWidget(String text, String hint, TextEditingController ctrl) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: TextFormField(
              controller: ctrl,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController donation = TextEditingController();

  TextEditingController quantity = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController athctrl = TextEditingController();

  TextEditingController btitle = TextEditingController();
   clearText() {
    donation.clear();
    quantity.clear();
    note.clear();
    athctrl.clear();
    btitle.clear();
  }

  String date = "";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                 Center(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Clothes Donation Form' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.grey[700]),),
                )),
                // HeadingWidget('Confirm Donation'),
                formWidget('Donation',
                    'Enter donation eg:"Black pant","Black shirt"', donation),
               
                Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  "Quantity",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                decoration: BoxDecoration(color: Colors.white),
                child: TextFormField(
                  maxLength: 2,
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: 'Enter donation Quantity eg:"3","4"',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                  ],
                ),
              ),
                formWidget('Note to NGO (optional)', 'Type here...', note),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                      DateTime now = DateTime.now().add(Duration(minutes: 30));
                      DatePicker.showTimePicker(context, showTitleActions: true,
                          onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        now.difference(date) > Duration(seconds: 1)
                            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Attention! At least 30 mins is required.')))
                            : setState(() {
                                _time = "${date.hour}:${date.minute}";
                              });
                      },
                          currentTime:
                              DateTime.now().add(Duration(minutes: 30)));
                    },
                      child: Text('SELECT TIME'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Pickup Time: $_time',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            chooseImage();
                          },
                          child: Text('Pick Image'),
                        ),
                        localmage.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 115, 161, 182),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          MemoryImage(base64Decode(localmage))),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 120,
                                width: 120,
                                color: Colors.orange.withOpacity(0.2),
                              ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  'Clothes For',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Center(child: BookList()),
                Divider(),
                _mySelection == "Kids" ? Course() : SizedBox(),
                _mySelection == "Adults" ? Adult() : SizedBox(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String foodType = _mySelection;
                          String time = _time;
                          List<ClothesModel> products = [
                            ClothesModel(
                                donation.text,
                                quantity.text,
                                note.text,
                                _mySelection,
                                course == null ? Size : course,
                                board == null ? adlt : board,
                                category,
                                time,
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                localmage)
                          ];
                          widget._valueSetter(products[0]);
                          setState(() {});

                          clearText();
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _time = "${DateTime.now().hour}:${DateTime.now().minute}";

  String _mySelection = foodtype.first;
static final List<String> foodtype = ['Kids', 'Adults'];

  
  Widget BookList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: _mySelection,
                  items: foodtype
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _mySelection = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
    // return DropdownButton<String>(
    //   hint: Text('Select Category'),
    //   items: foodtype.map((item) {
      //   return DropdownMenuItem(
      //     child: Text(
      //       item,
      //     ),
      //     value: item.toString(),
      //   );
      // }).toList(),
      // onChanged: (val) {
      //   setState(() {
      //     _mySelection = val.toString();
      //   });
      // },
      // value: _mySelection,
    // );
  }
  static final List<String> coursetype =
  
   ['0-3 months',
    '3-6 months',
    '6-12 months',
    '12-24 months',
    '2-3 years',
    '4-5 years',
    '6-7 years',
    '8-9 years',
    '10-11 years',
    '12-13 years'];
    
  
  String course = coursetype.first;


  Widget CourseList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: course,
                  items: coursetype
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      course = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
  }

  String board = boardList.first;
  static final List<String>boardList = ['boy', 'girl'];
  Widget BoardList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: board,
                  items: boardList
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      board = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
  }

  String Size = sizeList.first;
 static final List<String> sizeList = ['small', 'medium', 'large', 'XL', 'XXL'];
  Widget SizeList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Size',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: Size,
                  items: sizeList
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      Size = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
  }

  String category = categoryList.first;
  static final List<String> categoryList = [
    'Shirts or tops',
    'Jeans or Bottoms',
    'Sleepwear',
    'Shalwar Kameez',
    'Pant Shirt',
    'Others'
  ];
  Widget CategoryList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: category,
                  items: categoryList
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      category = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
    // return DropdownButton<String>(
    //   hint: Text('Select Category'),
    //   items: categoryList.map((item) {
    //     return DropdownMenuItem(
    //       child: Text(
    //         item,
    //       ),
    //       value: item.toString(),
    //     );
    //   }).toList(),
    //   onChanged: (val) {
    //     setState(() {
    //       category = val.toString();
    //     });
    //   },
    //   value: category,
    // );
  }

  String adlt = adltList.first;
  static final List<String> adltList = ['Male', 'Female'];
  Widget AdltList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Select Gender',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: DropdownButton(
                  value: adlt,
                  items: adltList
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      adlt = val.toString();
                    });

                    
                  },
                     icon: Padding(
                      //Icon at tail, arrow bottom is default icon
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                     iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    
                ),
              ),
            ),
            
          ],
        ));
  }

  Widget Adult() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Clothes Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    AdltList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizeList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CategoryList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Course() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Clothes Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CourseList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    BoardList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CategoryList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future makeDontion() async {
    String url = 'https://edonations.000webhostapp.com/api-donate.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'foodtype': _mySelection,
      'date'
          // 'user_id': widget.donorId,
          // 'ngo_id': widget.ngoId,
          'available_time': _time.toString()
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg != null) {
        Navigator.of(context).pop();
      }
    } else {
      SnackBar(content: Text('Error Please Try Later!'));
    }
  }
}
