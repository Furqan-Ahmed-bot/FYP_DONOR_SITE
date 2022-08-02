// ignore_for_file: file_names, prefer_initializing_formals

import 'package:multi_image_picker2/src/asset.dart';

class ProductModel {
  late String name;
  late String quantity;
  late String note;
  String? mySelection;
  // late String ngoname;
  String? time;
  late String date;
  String ?image;


  ProductModel(String name, String quantity, String note, String mySelection,
      String time, String date, String image) {
 
    this.name = name;
    this.quantity = quantity;
    this.note = note;
    this.mySelection = mySelection;
    // this.ngoname = ngoname;
    this.time = time;
    this.date = date;
    this.image = image;
    
  }
}
