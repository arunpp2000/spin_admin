import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../fucntions.dart';
import 'editreward.dart';

class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  List Events = [];
  getdata() {
    FirebaseFirestore.instance
        .collection('event')
        .where('delete', isEqualTo: false)
        .orderBy('addDate', descending: false)
        .snapshots()
        .listen((event) {
      Events = [];
      event.docs.forEach((element) {
        Events.add(element);
        // Events.add(element.id);
        print(element.id);
      });
      if (mounted) {
        setState(() {});
      }
    });
  }

  // getEvent() async {
  //   QuerySnapshot? regusr =
  //       await FirebaseFirestore
  //       .instance
  //       .collection(
  //       'event')
  //       .where('date',
  //       isGreaterThanOrEqualTo:
  //       yesterday).where('date',isLessThanOrEqualTo: today)
  //       .get().then((value) {
  //     value.docs.forEach((element) {
  //     print(element.id);
  //     Events.add(element.id);
  //     currentEventId=element.id;
  //       });
  //         });}
  TextEditingController dateController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController taskUpdateController = TextEditingController();
  bool edit = false;
  int selectedindex = 0;
  DateTime? picked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6FF),
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
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Result()));
        //   }, icon: Icon(Icons.wallet_giftcard))
        // ],
        // leading: IconButton(onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPass()));
        // }, icon:Icon(Icons.add)),
        title: Text(
          'Added Events',
          style: GoogleFonts.outfit(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Events.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrizeView(
                                id: Events[index]['id'],
                              )));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (buildContext) {
                        var date = Events[index]['date'].toDate();
                        taskUpdateController.text = Events[index]['eventName'];
                        dateController.text = DateFormat('dd MMM yyyy')
                            .format(Events[index]['date'].toDate());
                        return AlertDialog(
                          title: Text("Edit Event "),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                  child: TextField(
                                controller: taskUpdateController,
                                decoration:
                                    InputDecoration(hintText: 'Event name'),
                              )),
                              Flexible(
                                  child: TextField(
                                      controller: dateController,
                                      decoration:
                                          InputDecoration(hintText: 'date'),
                                      onTap: () async {
                                        picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2023),
                                            lastDate: DateTime(2025));
                                        if (picked != null) {
                                          dateController.text =
                                              DateFormat('dd MMM yyyy')
                                                  .format(picked!);
                                        }
                                      })),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (taskUpdateController.text != '' &&
                                            dateController.text != '') {
                                          FirebaseFirestore.instance
                                              .collection('event')
                                              .doc(Events[index]['id'])
                                              .update({
                                            'date': picked ?? date,
                                            'eventName':
                                                taskUpdateController.text,
                                          }).then((value) {
                                            showSnackbar('Updated successfully',
                                                context);
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          taskUpdateController.text == ''
                                              ? showSnackbar(
                                                  "Please Enter event Name",
                                                  context)
                                              : dateController.text == ''
                                                  ? showSnackbar(
                                                      " Choose event date",
                                                      context)
                                                  : null;
                                        }
                                      },
                                      child: Text("Update")),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Canel')),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(0.15),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          4,
                        ),
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Center(
                      child: Column(
                        children: [




                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    Events[index]['eventName']
                                        .toString()
                                        .toUpperCase(),
                                    style: GoogleFonts.outfit(
                                        fontSize: 20, fontWeight: FontWeight.w600)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (buildContext) {
                                          return AlertDialog(
                                            title: Text('Delete'),
                                            content: Text(
                                                'Do you want to Delete the Event ?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('event')
                                                        .doc(Events[index]['id'])
                                                        .update({'delete': true});
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok')),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                      'Scheduled Date: ' +
                          DateFormat('dd MMM yyyy')
                              .format(Events[index]['date'].toDate()),
                      style: GoogleFonts.outfit(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),



                            ],
                          )
                        ],
                      ),
                    ),
                    // leading: Text('${index+1}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
// IconButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (buildContext) {
// return AlertDialog(
// title: Text('Delete'),
// content:
// Text('Do you want to Delete the Event ?'),
// actions: [
// TextButton(
// onPressed: () => Navigator.pop(context),
// child: Text('Cancel')),
// TextButton(
// onPressed: () {
// FirebaseFirestore.instance
//     .collection('event')
//     .doc(Events[index]['id'])
//     .update({'delete': true});
// setState(() {});
// Navigator.pop(context);
// },
// child: Text('Ok')),
// ],
// );
// });
// },
// icon: Icon(
// Icons.delete,
// color: Colors.black,
// )),
//
//
//
//
//

// Text(
//                       'Scheduled Date: ' +
//                           DateFormat('dd MMM yyyy')
//                               .format(Events[index]['date'].toDate()),
//                       style: GoogleFonts.outfit(
//                           fontSize: 14, fontWeight: FontWeight.w500),
//                     ),
