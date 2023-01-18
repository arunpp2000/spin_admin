import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Winners extends StatefulWidget {
  var event;
  var eventName;

  Winners({
    Key? key,
    required this.event,
    required this.eventName,
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
  bool loading = false;
  String? eventName;
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

  List<String> columns = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "AA",
    "AB",
    "AC",
    "AD",
    "AE",
    "AF",
    "AG",
    "AH",
    "AI",
    "AJ",
    "AK",
    "AL",
    "AM",
    "AN",
    "AO",
    "AP",
    "AQ",
    "AR",
    "AS",
    "AT",
    "AU",
    "AV",
    "AW",
    "AX",
    "AY",
    "AZ",
    "BA",
    "BB",
    "BC",
    "BD",
    "BE",
    "BF",
    "BG",
    "BH",
    "BI",
    "BJ",
    "BK",
    "BL",
    "BM",
    "BN",
    "BO",
    "BP",
    "BQ",
    "BR",
    "BS",
    "BT",
    "BU",
    "BV",
    "BW",
    "BX",
    "BY",
    "BZ",
    "CA",
    "CB",
    "CC",
    "CD",
    "CE",
    "CF",
    "CG",
    "CH",
    "CI",
    "CJ",
    "CK",
    "CL",
    "CM",
    "CN",
    "CO",
    "CP",
    "CQ",
    "CR",
    "CS",
    "CT",
    "CU",
    "CV",
    "CW",
    "CX",
    "CY",
    "CZ",
    "DA",
    "DB",
    "DC",
    "DD",
    "DE",
    "DF",
    "DG",
    "DH",
    "DI",
    "DJ",
    "DK",
    "DL",
    "DM",
    "DN",
    "DO",
    "DP",
    "DQ",
    "DR",
    "DS",
    "DT",
    "DU",
    "DV",
    "DW",
    "DX",
    "DY",
    "DZ",
    "EA",
    "EB",
    "EC",
    "ED",
    "EE",
    "EF",
    "EG",
    "EH",
    "EI",
    "EJ",
    "EK",
    "EL",
    "EM",
    "EN",
    "EO",
    "EP",
    "EQ",
    "ER",
    "ES",
    "ET",
    "EU",
    "EV",
    "EW",
    "EX",
    "EY",
    "EZ",
    "FA",
    "FB",
    "FC",
    "FD",
    "FE",
    "FF",
    "FG",
    "FH",
    "FI",
    "FJ",
    "FK",
    "FL",
    "FM",
    "FN",
    "FO",
    "FP",
    "FQ",
    "FR",
    "FS",
    "FT",
    "FU",
    "FV",
    "FW",
    "FX",
    "FY",
    "FZ",
  ];
  bool called = false;

  List<String> selectedFields = [
    "joinDate", "name", "mobNo", 'job', "district", "place", 'prize'

    //  "password",

    //"mobno",
    // "status",
  ];
  getPurchases(QuerySnapshot<Map<String, dynamic>> data) async {
    int i = 1;
    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['event'];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#ffffff",
        fontFamily: getFontFamily(FontFamily.Calibri));
    if (data.docs.length > 0) {
      var cell = sheetObject.cell(CellIndex.indexByString("A1"));
      cell.value = 'SL NO'; // dynamic values support provided;
      cell.cellStyle = cellStyle;
      Map<String, dynamic> dt = data.docs[0].data();
      // print(dt.keys.toList().length);
      // print(dt.keys.toList());
      int k = 0;
      for (int n = 0; n < selectedFields.toList().length; n++) {
        if (selectedFields.contains(selectedFields.toList()[n])) {
          var cell =
              sheetObject.cell(CellIndex.indexByString("${columns[k + 1]}1"));
          cell.value =
              selectedFields.toList()[n]; // dynamic values support provided;
          cell.cellStyle = cellStyle;
          k++;
        }
      }
    }

    for (DocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
      int l = 0;
      var cell = sheetObject.cell(CellIndex.indexByString("A${i + 1}"));
      cell.value = i.toString(); // dynamic values support provided;
      cell.cellStyle = cellStyle;
      // double amt=0;
      // double commission=0;
      // String shopsId='';
      Map<String, dynamic> dt = data.docs[0].data();
      Map<String, dynamic> dta = doc.data()!;
      // print("hereeee");
      for (int n = 0; n < selectedFields.toList().length; n++) {
        if (selectedFields.contains(selectedFields.toList()[n])) {
          var cell = sheetObject
              .cell(CellIndex.indexByString("${columns[l + 1]}${i + 1}"));

          // if (dta[dt.keys.toList()[n]].runtimeType.toString() == "Timestamp") {
          if (selectedFields.toList()[n] == "joinDate") {
            cell.value = dta[selectedFields.toList()[n]].toDate().toString(); //
            cell.cellStyle = cellStyle;
          } else {
            cell.value = dta[selectedFields.toList()[n]].toString();
            cell.cellStyle = cellStyle;
          }
          l++;
        }

        //    dynamic values support provided;

      }

      i++;
    }

    excel.setDefaultSheet('events');
    // excel.save(fileName: widget.eventName.toString());
    // var fileBytes = excel.encode();
    excel.setDefaultSheet('sales');
    var fileBytes = excel.encode();
    var directory = await getExternalStorageDirectory();
    String outputFile =
        "${directory?.path!}/${widget.eventName.toString()}-${DateTime.now().toString().substring(0, 16)}.xlsx";

    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'file saved in application directory($outputFile)',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    OpenFile.open(outputFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                print('23232323');
                setState(() {
                  loading = true;
                });
                QuerySnapshot<Map<String, dynamic>> data =
                    await FirebaseFirestore.instance
                        .collection('event')
                        .doc(widget.event)
                        .collection('users')
                        .get();
                await getPurchases(data);
                setState(() {
                  loading = false;
                });
              },
              icon: Icon(Icons.download))
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
              height: 155,
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
                          'Name : ' + Result[index]['name'].toString(),
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
                        Text(
                          'Place : ' + Result[index]['place'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Job : ' + Result[index]['job'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Reward : ' +
                              Result[index]['reward']['prize'].toString(),
                          style: GoogleFonts.outfit(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
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
