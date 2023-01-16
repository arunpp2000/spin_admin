import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spin_admin/admin/result.dart';
import '../fucntions.dart';
import 'addrewards.dart';
import 'eventview.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var loginkey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController eventController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  @override
  Widget build(BuildContext context) {
    // Future<void> _selectDate(BuildContext context) async {
    //  await showDatePicker(
    //       context: context,
    //       initialDate: selectedDate,
    //       firstDate: DateTime(2023),
    //       lastDate: DateTime(2023)).then((value) {
    //         value = picked;
    //   });
    //
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 7,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => Report()));
        //       },
        //       icon: Icon(Icons.wallet_giftcard_outlined)),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => EventView()));
        //       },
        //       icon: Icon(Icons.list)),
        // ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15, bottom: 15),
                      //   child: Text(
                      //     'Event Name',
                      //     style: TextStyle(color: Colors.black, fontSize: 17),
                      //   ),
                      // ),
                      TextFormField(
                        controller: eventController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Event Name',
                          labelStyle: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          hintText: 'Enter the event Name',
                          hintStyle: GoogleFonts.outfit(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          // labelText: 'Your ID',
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          'Choose event date',
                          style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextField(
                        controller: dateController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          // labelText: 'Your ID',
                        ),
                        onTap: () async {
                          picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2025));
                          if (picked != null) {
                            dateController.text =
                                DateFormat('dd MMM yyyy').format(picked!);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // <-- Radius
                            ),
                          ),
                          child: Text('SUBMIT',
                              style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          onPressed: () async {
                            final FormState? form = formKey.currentState;
                            if (form!.validate()) {
                              if (eventController.text != '' &&
                                  dateController.text != '') {
                                DocumentSnapshot doc = await FirebaseFirestore
                                    .instance
                                    .collection('settings')
                                    .doc('settings')
                                    .get();
                                FirebaseFirestore.instance
                                    .collection('settings')
                                    .doc('settings')
                                    .update({
                                  'event': FieldValue.increment(1),
                                });
                                int a = doc['event'];
                                a++;
                                FirebaseFirestore.instance
                                    .collection('event')
                                    .doc(a.toString())
                                    .set({
                                  'delete': false,
                                  'id': a.toString(),
                                  'date': picked,
                                  'eventName': eventController.text,
                                  'reward': [],
                                  'addDate': FieldValue.serverTimestamp()
                                }).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Rewards(
                                                event: eventController.text,
                                                id: a.toString(),
                                              )));
                                });
                              } else {
                                eventController.text == ''
                                    ? showSnackbar(
                                        "Please Enter event Name", context)
                                    : dateController.text == ''
                                        ? showSnackbar(
                                            " Choose event date", context)
                                        : null;
                              }
                            }
                          }))
                ],
              )),
        ),
      ),
    );
  }
}
