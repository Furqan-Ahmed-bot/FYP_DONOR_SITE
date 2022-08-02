// ignore_for_file: prefer_const_constructors

import 'package:dashboard_final/otp_verification.dart';
import 'package:dashboard_final/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Welcome To Edonation App',
              body: 'a smart, easy and fast way to donate from your home.',
              image: buildImage('assets/01.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Easy Donation',
              body: 'Donate Food, Clothes and Books at your fingerprints',
              image: buildImage('assets/clothess.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'For enhanced donation experience',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Making a donation is the ultimate sign of solidarity.',
              body: '',
              footer: Container(
                height: 50,
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  color: Color(0xFFFF7643),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Welcome()));
                  },
                ),
              ),
              //  ButtonWidget(

              //   text: 'Start Reading' , onClicked: () {   Navigator.push(context,
              //                 MaterialPageRoute(builder: (context) => Welcome()));},

              //   // onClicked: () => goToHome(context),
              // ),
              image: buildImage('assets/learn.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Welcome())),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () { Navigator.push(
              context, MaterialPageRoute(builder: (context) => Welcome()));
              
              
              },
              

          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  // void goToHome(context) => Navigator.of(context).pushReplacement(
  //       // MaterialPageRoute(builder: (_) => HomePage()),
  //     );

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 350,
        height: 450,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        // color: Color(0xFFBDBDBD),
        activeColor: Color(0xFFFF7643),
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
