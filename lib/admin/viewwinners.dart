import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Winners extends StatefulWidget {
  var event;

  Winners({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  Timestamp? yesterday;
  Timestamp? today;
  @override
  void initState() {
    getdata();
    // DateTime? time=DateTime.now();
    // yesterday = Timestamp.fromDate(DateTime(time.year,time.month,time.day,0,0,0));
    // today = Timestamp.fromDate(DateTime(time.year,time.month,time.day,23,59,59));
    // TODO: implement initState
    super.initState();
  }

  List Result = [];

  getdata() {
    FirebaseFirestore.instance
        .collection('event')
        .doc(widget.event)
        .collection('users')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        Result.add(element);
        print(element.id);
      });
      setState(() {});
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){




          }, icon: Icon(Icons.download))
        ],
        backgroundColor: Colors.black,
        elevation: 7,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left)),
        title: Text('Winners',
            style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Result.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 135,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                  leading: Text(
                    '${index + 1}',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Name : ' + Result[index]['userName'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Mobile Number : ' +
                              Result[index]['mobNo'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'District : ' + Result[index]['district'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text('Place : ' + Result[index]['place'].toString(), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),),
                        Text('Job : ' + Result[index]['job'].toString(), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
