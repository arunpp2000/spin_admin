


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spin_admin/admin/homepage.dart';
import 'package:spin_admin/splashscreen.dart';

import 'loginpage.dart';


void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAczlZLcwoCLIZ0ko1yYpa6iRFgvVC0wIk",
            authDomain: "spinningwheel-dd930.firebaseapp.com",
            projectId: "spinningwheel-dd930",
            storageBucket: "spinningwheel-dd930.appspot.com",
            messagingSenderId: "36263498048",
            appId: "1:36263498048:web:0ad3f63e13dd491ea8eaa5",
            measurementId: "G-RHGEVS1NQ4"
        ));

    runApp(const MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Login(),
    );
  }
}

