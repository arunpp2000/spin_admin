import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spin_admin/admin/viewwinners.dart';


class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
        .orderBy('date', descending: false)
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
  TextEditingController passController = TextEditingController();
  TextEditingController taskUpdateController = TextEditingController();
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
        title: Text('Report',
            style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Events.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: InkWell(
                onTap: () {
                  print('dddddd');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Winners(
                                event: Events[index]['id'],
                              )));
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
                    title: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            Events[index]['eventName'].toString().toUpperCase(),
                            style: GoogleFonts.outfit(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                              'Date: ' +
                                  DateFormat('dd MMM yyyy')
                                      .format(Events[index]['date'].toDate()),
                              style: GoogleFonts.outfit(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
