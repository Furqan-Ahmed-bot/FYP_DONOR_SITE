
import 'package:dashboard_final/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'donor_appbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var donorId = preferences.getString('user_id');
  var email = preferences.getString('email');
  var address = preferences.getString('address');
  var username = preferences.getString('username');
  var contact = preferences.getString('contact');
  var password = preferences.getString('password');
  var image = preferences.getString('image');
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/login': (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(

      primary: const Color(0xFFFF7643),
      secondary: const Color(0xFFFF7643),

      // or from RGB

    

    ),
  ),
    home: email == null
        ? OnBoardingPage()
        : DonorAppBar(int.parse(donorId!), address, username, contact, email,
            password, image),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage()
    );
  }
}
