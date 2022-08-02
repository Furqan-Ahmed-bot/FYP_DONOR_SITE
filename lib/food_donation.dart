// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:typed_data';
import 'package:dashboard_final/models/donationCartModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'models/Users.dart';

class ConfirmFoodDonation extends StatefulWidget {
  int donorId;
  int ngoId;

  final ValueSetter<ProductModel> _valueSetter;

  ConfirmFoodDonation(this.donorId, this.ngoId, this._valueSetter);
  @override
  State<ConfirmFoodDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmFoodDonation> {
  // UserModel? model;
  String? donorEmail;
  String? ngoEmail;
  String localmage = '';

  // List<Asset> images = [];
  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 1,
  //     crossAxisSpacing: 3,
  //     children: List.generate(images.length, (index) {
  //       Asset asset = images[index];
  //       return AssetThumb(
  //         asset: asset,
  //         width: 100,
  //         height: 100,
  //       );
  //     }),
  //   );
  // }

  // Future<void> loadAssets() async {
  //   List<Asset> resultList = [];
  //   String error = 'No Error Detected';

  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 1,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       cupertinoOptions: CupertinoOptions(
  //         takePhotoIcon: "chat",
  //         doneButtonTitle: "Fatto",
  //       ),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#abcdef",
  //         actionBarTitle: "Example App",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     error = e.toString();
  //   }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     // images = resultList;
  //     // print("Result is $resultList");
  //   });
  // }

  Future<String> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imagePicker =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    // XFile is now recommended to use with ImagePicker
    // File? _imagePicker;

    // This Line of Code will pick the image from your gallery
    // _imagePicker =
    //     await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 1);

    //Our XFile variable is nullable so we've to check if we've picked the image or not
    if (_imagePicker != null) {
      // Now we're converting our image into Uint8List
      Uint8List bytes = await _imagePicker.readAsBytes();

      // Here we're converting our image to Base64
      String encode = base64Encode(bytes);

      // Returning Base64 Encoded Image
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
    // password: password.text,
    // fullname: fullName.text,
    // username: username.text,
  }

  @override
  void initState() {
    super.initState();
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
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
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
  
   clearText() {
    donation.clear();
    quantity.clear();
    note.clear();
  }



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
      List<ProductModel> products = [
        ProductModel(
          donation.text,
          quantity.text,
          note.text,
          foodType,
          time,
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          localmage,
        )
      ];
      widget._valueSetter(products[0]);
      setState(() {});
    }
  }

  String? date;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
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
                height: MediaQuery.of(context).size.height * 0.03,
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
                    'Selected time: $_time',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                    ),
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
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(child: myfoodlist()),
              SizedBox(
                height: 50,
              ),
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
                        print(" Image is $localmage");
                        clearText();
                        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Donation Added in the Donation box')));
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  String _time = "${DateTime.now().hour}:${DateTime.now().minute}";

  // String? _mySelection;
  // List foodtype = ['can be stored', 'can not be stored'];
  // Widget foodList() {
  //   return DropdownButton<String>(
  //     hint: Text('Select Food Type'),
  //     items: foodtype.map((item) {
  //       return new DropdownMenuItem(
  //         child: new Text(
  //           item,
  //         ),
  //         value: item.toString(),
  //       );
  //     }).toList(),
  //     onChanged: (val) {
  //       setState(() {
  //         _mySelection = val.toString();
  //       });
  //     },
  //     value: _mySelection,
  //   );
  // }
  static final List<String> boardList = <String>[
    'can be stored',
    'can not be stored',
  ];
  String _mySelection = boardList.first;
  Widget myfoodlist() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: Column(children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFFF7643), //background color of dropdown button
                  border: Border.all(
                      color: Colors.black38,
                      width: 3), //border of dropdown button
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
                    items: boardList
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

  Future makeDontion() async {
    String url = 'https://edonations.000webhostapp.com/api-donate.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'date': date,
      'food_type': _mySelection,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': _time.toString(),
      'image': localmage,
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
