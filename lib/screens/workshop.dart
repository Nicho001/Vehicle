import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/main.dart';
import 'package:kajal/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'compliantreg.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class workshop {
  final String name;
  final String image;
  final String location;
  final String number;

  workshop(
      {required this.name,
      required this.image,
      required this.location,
      required this.number});
}

class ScreenWorkshop extends StatefulWidget {
  ScreenWorkshop({Key? key}) : super(key: key);

  @override
  State<ScreenWorkshop> createState() => _ScreenWorkshopState();
}

class _ScreenWorkshopState extends State<ScreenWorkshop> {
  List<workshop> wor = [];
  void didChangeDependencies() {
    work();
    super.didChangeDependencies();
  }

  Future work() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var url1 = "https://great-wheels.herokuapp.com/workshops/$place/$category";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      // setState(() {
      //   _isLoading = false;
      // });
      var responseData = json.decode(response.body);
      for (var u in responseData) {
        //print(u);
        setState(() {
          wor.add(workshop(
              name: u["name"],
              image: u["image"],
              location: u["location"],
              number: u["number"]));
        });
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ScreenHome(),
              ));
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        title: Text(
          'Workshop',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: SafeArea(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return Container(
              // height: 85,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    nini = wor[index].name;
                    // indexofshop = index;
                    // print(indexofshop);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => complaint(),
                      ),
                    );
                  });
                },
                child: ListTile(
                  title: Text(
                    wor[index].name,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                  subtitle: Text(
                    wor[index].location,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(wor[index].image),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Container(
                      height: 30,
                      width: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          final Uri url = Uri.parse('tel:' + wor[index].number);
                          UrlLauncher.launchUrl(url);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 0, 0, 0),
                            side: BorderSide(color: Colors.white, width: 0),
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        child: Text(
                          "Call",
                          style: GoogleFonts.poppins(
                              fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider(
              color: Color.fromARGB(255, 207, 207, 207),
            );
          },
          itemCount: wor.length,
        ),
      ),
    );
  }
}
