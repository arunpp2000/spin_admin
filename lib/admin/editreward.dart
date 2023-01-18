import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../fucntions.dart';
import '../utils.dart';

class PrizeView extends StatefulWidget {
  final String id;
  PrizeView({Key? key, required this.id}) : super(key: key);

  @override
  State<PrizeView> createState() => _PrizeViewState();
}

class _PrizeViewState extends State<PrizeView> {
  TextEditingController prizeController = TextEditingController();
  TextEditingController brandController = TextEditingController();

  TextEditingController upBController = TextEditingController();
  TextEditingController upPController = TextEditingController();
  var loginkey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getRewards() {
    FirebaseFirestore.instance
        .collection('event')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      rewards = event.data()!['reward'];
      e = event.data()!['eventName'];
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getRewards();
    // TODO: implement initState
    super.initState();
  }

  bool edit = false;
  int selectedindex = 0;
  String? e;
  List rewards = [];
  final ScrollController sroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    var scrHeight = Utils().getScreenSize().height;
    var scrWidth = Utils().getScreenSize().width;
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
        title: Text(
          e!,
          style: GoogleFonts.outfit(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          controller: sroll,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('Brand Name'),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: false,
                        controller: brandController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Brand Name',
                          labelStyle: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          hintText: 'Enter the Brand Name',
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
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text('Prize Name'),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // validator: (value){
                        //   String patttern = r'(^[0-9]*$)';
                        //   RegExp regExp =
                        //   new RegExp(patttern);
                        //   if (value!.isEmpty) {
                        //     return "prize is Required";
                        //   } else if (!regExp
                        //       .hasMatch(value)) {
                        //     return "Prize must be digits";
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        controller: prizeController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Category Name',
                          labelStyle: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          hintText: 'Enter the Category Name',
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        edit == true
                            ? Container(
                                width: 150,
                                height: 50,
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    child: Text('Cancel',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      edit = false;
                                      setState(() {});
                                    }))
                            : Container(),
                        Container(
                            width: 150,
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15), // <-- Radius
                                  ),
                                ),
                                child: Text(edit == true ? 'Update' : 'ADD',
                                    style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white)),
                                onPressed: () {
                                  final FormState? form = formKey.currentState;
                                  if (form!.validate()) {
                                    if (brandController.text != '' &&
                                        prizeController.text != '') {
                                      if (edit == true) {
                                        rewards.removeAt(selectedindex);
                                        rewards.insert(selectedindex, {
                                          'brand': brandController.text,
                                          'prize': prizeController.text,
                                        });
                                        FirebaseFirestore.instance
                                            .collection('event')
                                            .doc(widget.id)
                                            .update({
                                          'reward': rewards,
                                        }).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text("Updated"),
                                            ),
                                          );
                                        }).then((value) {
                                          edit = false;
                                          setState(() {});
                                          brandController.clear();
                                          prizeController.clear();
                                        });
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('event')
                                            .doc(widget.id)
                                            .update({
                                          'reward': FieldValue.arrayUnion([
                                            {
                                              'brand': brandController.text,
                                              'prize': prizeController.text,
                                            }
                                          ])
                                        }).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text("Added"),
                                            ),
                                          );
                                        }).then((value) {
                                          brandController.clear();
                                          prizeController.clear();
                                        });
                                      }
                                    } else {
                                      brandController.text == ''
                                          ? showSnackbar(
                                              "Please enter brand name",
                                              context)
                                          : prizeController.text == ''
                                              ? showSnackbar(
                                                  "Please enter the prize",
                                                  context)
                                              : null;
                                    }
                                  }
                                })),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: rewards.length,
                        itemBuilder: (context, index) {
                          return rewards.length == 0
                              ? Text('empty')
                              : SizedBox(
                                  height: 100,
                                  child: InkWell(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (buildContext) {
                                            return AlertDialog(
                                              title: Text('Edit List'),
                                              content:
                                                  Text('Do you want to edit ?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      edit = true;
                                                      brandController.text =
                                                          rewards[index]
                                                              ['brand'];
                                                      prizeController.text =
                                                          rewards[index]
                                                              ['prize'];
                                                      selectedindex = index;
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                    child: Text('Ok')),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff000000)
                                                .withOpacity(0.15),
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
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Brand  :  ' +
                                                      rewards[index]['brand'],
                                                  style: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                // IconButton(onPressed: (){
                                                //   showDialog(context: context,
                                                //     builder: (BuildContext context) {
                                                //       return AlertDialog(
                                                //         title: Text("Edit"),
                                                //         content: Column(
                                                //           mainAxisSize: MainAxisSize.min,
                                                //           children: [
                                                //             Flexible(child: TextField(
                                                //               controller: upBController,
                                                //             )),
                                                //             ElevatedButton(onPressed: (){
                                                //               FirebaseFirestore.instance.collection('user').doc(data[index]['brand']).update({
                                                //               'reward':
                                                //               {
                                                //               'brand': upBController.text,
                                                //               }
                                                //               });
                                                //               Navigator.pop(context);
                                                //             },
                                                //                 child: Text("Update"))
                                                //           ],
                                                //         ),
                                                //       );
                                                //     },);
                                                // },
                                                //     icon:Icon(Icons.edit)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Category  :  ${rewards[index]['prize']}',
                                                  style: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                // IconButton(onPressed: (){
                                                //   showDialog(context: context,
                                                //     builder: (BuildContext context) {
                                                //       return AlertDialog(
                                                //         title: Text("Edit"),
                                                //         content: Column(
                                                //           mainAxisSize: MainAxisSize.min,
                                                //           children: [
                                                //             Flexible(child: TextField(
                                                //               // controller: taskUpdateController,
                                                //             )),
                                                //             ElevatedButton(onPressed: (){
                                                //               FirebaseFirestore.instance.collection('user').doc(data[index]['prize']).update({
                                                //                 'reward':
                                                //                 {
                                                //                   'prize': upBController.text,
                                                //                 }
                                                //               });
                                                //               Navigator.pop(context);
                                                //             },
                                                //                 child: Text("Update"))
                                                //           ],
                                                //         ),
                                                //       );
                                                //     },);
                                                // },
                                                //     icon:Icon(Icons.edit)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        leading: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Container(
                                          width: 100,
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (buildContext) {
                                                    return AlertDialog(
                                                      title: Text('Alert'),
                                                      content: Text(
                                                          'Do you want to delete the reward ?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text('Cancel')),
                                                        TextButton(
                                                            onPressed: () {
                                                              rewards.removeAt(
                                                                  index);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'event')
                                                                  .doc(
                                                                      widget.id)
                                                                  .update({
                                                                'reward':
                                                                    rewards
                                                              });
                                                              edit = false;
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('Ok')),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.delete),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
