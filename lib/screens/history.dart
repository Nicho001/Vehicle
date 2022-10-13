import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class Cerashop1 {
  final String make;
  final String model;
  //final String description;
  final String complaint;
  final String number;
  final String date;

  Cerashop1(
      {required this.make,
      required this.model,
      //required this.description,
      required this.complaint,
      required this.number,
      required this.date});
}

class Screencera1 extends StatefulWidget {
  Screencera1({Key? key}) : super(key: key);

  @override
  State<Screencera1> createState() => _Screencera1State();
}

class _Screencera1State extends State<Screencera1> {
  bool favv = false;
  bool isFavourite = true;
  void initState() {
    //searchshop();

    // reload();
    super.initState();
    // futureData = shopdetails();
  }

  void didChangeDependencies() {
    searchshop();
    super.didChangeDependencies();
  }

  List<Cerashop1> product1 = [];

  Future searchshop() async {
    var url2 =
        "https://great-wheels.herokuapp.com/recent/complaints/$kadayudeperu";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response2.statusCode == 200) {
      var responseData2 = json.decode(response2.body);

      for (var u in responseData2) {
        print(u);
        setState(() {
          product1.add(Cerashop1(
              make: u["vehicleMake"],
              model: u["vehicleModel"],
              complaint: u["complaint"],
              number: u["vehicleNumber"],
              date: u["date"]));
        });

        //print(product[0].price);
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          kadayudeperu,
          style: GoogleFonts.poppins(),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) => Screensearchcera(),
        //           ),
        //         );
        //       },
        //       icon: Icon(Icons.search)),
        //   IconButton(
        //       onPressed: () {
        //         setState(() {
        //           if (!isFavourite) {
        //             addtofavor();
        //           }
        //           if (isFavourite) {
        //             removefromfavor();
        //           }
        //           isFavourite = !isFavourite;
        //         });
        //       },
        //       icon: Icon(
        //         Icons.favorite,
        //         color: isFavourite ? Colors.red : Colors.white,
        //       )),
        // ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: ListView.separated(
        itemCount: product1.length,
        physics: RangeMaintainingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          return Container(
            height: 75,
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                  title: Text(
                    product1[index].make + ' ' + product1[index].model,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                  subtitle: Text(
                    product1[index].complaint,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                  ),
                  // leading: CircleAvatar(
                  //   radius: 25,
                  //   backgroundImage: NetworkImage(product[index].images),
                  // ),
                  trailing: Container(
                    width: 35,
                    child: Text(
                      product1[index].date,
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 66, 66, 66), fontSize: 13),
                    ),
                  )),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return Divider(
            color: Color.fromARGB(255, 196, 196, 196),
          );
        },
      ),
    ));
  }
}
