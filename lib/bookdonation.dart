// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:typed_data';
import 'package:dashboard_final/models/booksCartModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import './headingWidget.dart';
import 'models/donationCartModel.dart';

class ConfirmBookDonation extends StatefulWidget {
  int donorId;
  int ngoId;

  final ValueSetter<BooksModel> _valueSetter;

  ConfirmBookDonation(this.donorId, this.ngoId, this._valueSetter);
  @override
  State<ConfirmBookDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmBookDonation> {
  String? donorEmail;
  String? ngoEmail;

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

  List<Asset> images = [];
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
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

  void vaildation() {
    if (donation.text.isEmpty && quantity.text.isEmpty && note.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Fleids Are Empty"),
        ),
      );
    } else if (donation.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Donation Is Empty"),
        ),
      );
    } else if (quantity.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Quantity Is Empty"),
        ),
      );
    } else {
      String foodType = _mySelection;
      String time = _time;
      List<BooksModel> products = [
        BooksModel(
            donation.text,
            quantity.text,
            note.text,
            _mySelection,
            course == null ? btitle.text : course,
            board == null ? athctrl.text : board,
            time,
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            localmage)
      ];
      widget._valueSetter(products[0]);

      setState(() {});
    }
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
                  child: Text('Book Donation Form' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.grey[700]),),
                )),
                formWidget(
                    'Donation', 'Enter donation eg:"books","curry"', donation),
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
                    controller: quantity,
                    decoration: InputDecoration(
                      hintText: 'Enter donation Quantity eg:"3","4"',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9a-zA-Z]"),
                      ),
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
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          setState(() {
                            _time = "${date.hour}:${date.minute}";
                          });
                        }, currentTime: DateTime.now());
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
                                  image: MemoryImage(base64Decode(localmage))),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    'Book Category',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Center(child: BookList()),
                Divider(),
                _mySelection == "Course" ? Course() : SizedBox(),
                _mySelection == "Others" ? BookDetails() : SizedBox(),
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
                          vaildation();
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

  String _time = "";
  static final List<String> bookList = <String>[
    'Course',
    'Others',
  ];
  String _mySelection = bookList.first;
  Widget BookList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                'Select Book Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFFF7643),//background color of dropdown button
                  border: Border.all(
                      
                      ), //border of dropdown button
                  //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[
                    //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color(0xFFFF7643),//shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: DropdownButton(
                    value: _mySelection,
                    items: bookList
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),

                    onChanged: (value) {
                      //get value when changed
                      setState(() {
                        this._mySelection = value.toString();
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
                    isExpanded: true, //make true to make width 100%
                  ))),
        ]));
  }

  String course = coursetype.first;
  static final List<String> coursetype = <String>[
    'pre',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10',
    '11',
    '12'
  ];
  Widget CourseList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                'Select Grade',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          DecoratedBox(
              decoration:BoxDecoration(
                  color: Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(
                      ), //border of dropdown button
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

                    onChanged: (value) {
                      //get value when changed
                      setState(() {
                        this.course = value.toString();
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
                    isExpanded: true, //make true to make width 100%
                  ))),
        ]));
  }

  String board = boardList.first;
  static final List<String> boardList = <String>[
    'Sindh Board',
    'Punjab Board',
    'KPK board',
    'Balochistan Board',
    'Federal Board'
  ];
  Widget BoardList() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                'Select Board',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(
                      ), //border of dropdown button
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

                    onChanged: (value) {
                      //get value when changed
                      setState(() {
                        this.board = value.toString();
                      });
                    },
                    icon: Padding(
                        //Icon at tail, arrow bottom is default icon
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_downward)),
                    iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),

                    dropdownColor: Color(0xFFFF7643),
                    //dropdown background color
                    underline: Container(), //remove underline
                    isExpanded: true, //make true to make width 100%
                  ))),
        ]));
  }

  Widget Course() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Course Details',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
              ),
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
    String url = 'https://edonations.000webhostapp.com/api-donate-books.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'date': date,
      'book_type': _mySelection,
      'book_detail1': board,
      'book_detail2': course,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': _time.toString(),
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

  Widget BookDetails() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          formWidget('Book title', 'Enter book title', btitle),
          formWidget('Book author', 'Enter book author name', athctrl)
        ],
      ),
    );
  }
}
