import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spin_admin/admin/homepage.dart';
import 'package:spin_admin/fucntions.dart';
import 'package:spin_admin/utils.dart';

import 'color and size.dart';


class Login extends StatefulWidget {

  Login({Key? key,}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController nameController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewards();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  getRewards() {
    FirebaseFirestore.instance
        .collection('settings')
        .doc('settings')
        .snapshots()
        .listen((event) {
      pass = event.get('pass');
      if (mounted) {
        setState(() {});
      }
    });
  }
  var pass;

  @override
  Widget build(BuildContext context) {
    print(pass);
    var scrHeight = Utils().getScreenSize().height;
    var scrWidth = Utils().getScreenSize().width;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 7,
          toolbarHeight: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          title: Text('Login',
              style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 25),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: nameController,
                      cursorRadius: const Radius.circular(12),
                      cursorColor: secondaryColor,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: primaryColor,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scrHeight * 0.04),
                     Center(
                  child: SizedBox(
                    width: Utils().getScreenSize().width * 0.40,
                    height: Utils().getScreenSize().height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                         if(nameController.text==pass.toString()){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => HomePage()),

                           );
                           nameController.clear();
                         }else{
                           showSnackbar('Invalid password', context);
                         }

                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            secondaryColor),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.outfit(
                            color: textColor,
                            fontSize: buttonTextSize,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.04,
                ),
                // Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       const Text(
                //         "Don't have an account?",
                //         style: TextStyle(
                //             color: primaryColor,
                //             fontSize: normalTextSize,
                //             fontWeight: FontWeight.w500),
                //       ),
                //       SizedBox(
                //         width: scrWidth * 0.02,
                //       ),
                //
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showUploadMessage(String message, BuildContext context,
      {bool showLoading = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: showLoading
              ? const Duration(minutes: 30)
              : const Duration(seconds: 4),
          content: Row(
            children: [
              if (showLoading)
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: CircularProgressIndicator(),
                ),
              Text(message),
            ],
          ),
        ),
      );
  }
}
