
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spin_admin/admin/result.dart';

import 'addEvent.dart';
import 'eventview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        elevation: 7,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: Text(
          'Admin',
          style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEvent()),
                  );
                },
                child: Container(
                  width: 140,
                  height: 160,

                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                      // image: DecorationImage(
                      //     image:  AssetImage('assets/addevent.png')),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]
                    //color mixing

                  ),
                  child: Center(child: Text('  Add  Event',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),),



                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventView()),
                  );
                },
                child: Container(
                  width: 140,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15),
                    // image: DecorationImage(
                    //     image:  AssetImage('assets/edit.png',)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Text("Edit Events",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),),

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Report()),
                  );
                },
                child: Container(
                  width: 140,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(15),
                    // image: DecorationImage(
                    //     image:  AssetImage('assets/report.png',)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Text("Reports", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),),


                ),
              ),
              SizedBox(width:16,),
            ],
          ),
        ),
      ),
    );
  }
}
