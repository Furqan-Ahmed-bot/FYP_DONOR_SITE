import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

//* Paste Your API Here
// String api = 'http://demo.bingertech.com/'; // Add Your API Here

String uploadAPI = 'https://edonations.000webhostapp.com/api-updatedonor.php';
String getAPI = "https://edonations.000webhostapp.com/getprofile.php";
// String getAPI = '$api/getUserProfile.php';

/*
* This Function is trigger when you press register button
* It provide the functionality to pick image from Gallery
*/
Future<String> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? _imagePicker =
      await _picker.pickImage(source: ImageSource.gallery);
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

Future registration({
  // required String username,
  // required String fullname,
  // required String password,
  required String image,
}) async {
  try {
    final response = await http.post(
      Uri.parse(uploadAPI),
      body: {
        'image': image,
        //   'username': username,
        //   'password': password,
        //   'fullName': fullname,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      if (kDebugMode) {
        print('Error 1');
      }
      return 'Error';
    }
  } catch (e) {
    return 'Error';
  }
}

// Future getUserProfile({required String username}) async {
//   try {
//     final response = await http.post(
//       Uri.parse(getAPI),
//       body: {'username': username},
//     );

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       return result;
//     } else {
//       if (kDebugMode) {
//         print('Error 1');
//       }
//       return 'Error';
//     }
//   } catch (e) {
//     return 'Error';
//   }
// }
