import 'package:flutter/material.dart';

// color
const Color primaryColor = Color(0xffc5c4c5);
const Color secondaryColor = Color(0xff474647);
const Color backgroundColor = Color(0xfff2f2f2);
const Color textColor = Color(0xffffffff);
const Color otpTextColor = Color(0xff464542);
const Color otpBackgroundColor = Color(0xffE8EBF1);
// size
const double titleTextSize = 20;
const double normalTextSize = 15;
const double subtitleTextSize = 18;
const double buttonTextSize = 16;
const double appBarIconSize = 30;
//padding
const double padding5 = 5;
const double padding10 = 10;
const double padding15 = 15;
const double padding20 = 20;

//BottomNavigationBar CenterWidget Gradient

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
);
// border for all 3 colors
final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffe65c00),
      Color(
        0xffF9D423,
      ),
      Color(0xff6dd5ed),
    ],
  ),
  // border: Border.all(
  //   color: Colors.amber, //kHintColor, so this should be changed?
  // ),
  borderRadius: BorderRadius.circular(32),
);
