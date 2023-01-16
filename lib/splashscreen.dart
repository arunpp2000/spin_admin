import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spin_admin/admin/addEvent.dart';


import '../utils.dart';


var scrHeight;
var scrWidth;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (context,_, __) =>  AddEvent()));
    });
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = Utils().getScreenSize().height;
    scrWidth = Utils().getScreenSize().width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/actizologo.png')),
    );
  }
}
