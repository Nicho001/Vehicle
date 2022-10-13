import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kajal/screens/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'home.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class Cerashop {
  final String name;
  final String location;
  //final String description;
  final String images;

  Cerashop({
    required this.name,
    required this.location,
    //required this.description,
    required this.images,
  });
}

class Screencera extends StatefulWidget {
  Screencera({Key? key}) : super(key: key);

  @override
  State<Screencera> createState() => _ScreenceraState();
}

class _ScreenceraState extends State<Screencera> {
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

  List<Cerashop> product = [];

  Future searchshop() async {
    var url2 = "https://great-wheels.herokuapp.com/recent/complaints";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response2.statusCode == 200) {
      var responseData2 = json.decode(response2.body);

      for (var u in responseData2) {
        print(u);
        setState(() {
          product.add(Cerashop(
              name: u["shopName"],
              location: u["shopLocation"],
              images: u["shopImage"]));
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
          'Recent Shops',
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
        itemCount: product.length,
        physics: RangeMaintainingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          return Container(
            height: 75,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  kadayudeperu = product[index].name;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screencera1(),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  product[index].name,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                ),
                subtitle: Text(
                  product[index].location,
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 49, 49, 49), fontSize: 13),
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(product[index].images),
                ),
                // trailing: Text(
                //   product[index].price,
                //   style: GoogleFonts.poppins(
                //       color: Color.fromARGB(255, 170, 170, 170), fontSize: 13),
                // )
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return Divider(
            color: Color.fromARGB(42, 180, 180, 180),
          );
        },
      ),
    ));
  }
}
