import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/screens/compliantreg.dart';
import 'package:kajal/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kajal/screens/home.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../main.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class tyre {
  final String name;
  final String image;
  final String location;
  final String number;

  tyre(
      {required this.name,
      required this.image,
      required this.location,
      required this.number});
}

class ScreenTyre extends StatefulWidget {
  ScreenTyre({Key? key}) : super(key: key);

  @override
  State<ScreenTyre> createState() => _ScreenTyreState();
}

class _ScreenTyreState extends State<ScreenTyre> {
  List<tyre> ty = [];
  void didChangeDependencies() {
    tyres();
    super.didChangeDependencies();
  }

  Future tyres() async {
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
        print("hai");
        print(u);
        setState(() {
          ty.add(tyre(
              name: u["name"],
              image: u["image"],
              location: u["location"],
              number: u["number"]));
        });
        print(ty[0].name);
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ScreenHome(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
        title: Text(
          'Tyre Services',
          style: GoogleFonts.poppins(),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        // ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: SafeArea(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return Container(
              //height: 75,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // indexofshop = index;
                    // print(indexofshop);
                    nini = ty[index].name;
                    print(nini);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => complaint(),
                      ),
                    );
                  });
                },
                child: ListTile(
                  title: Text(
                    ty[index].name,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                  ),
                  subtitle: Text(
                    ty[index].location,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(ty[index].image),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Container(
                      height: 30,
                      width: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          final Uri url = Uri.parse('tel:' + ty[index].number);
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
              color: Color.fromARGB(255, 198, 198, 198),
            );
          },
          itemCount: ty.length,
        ),
      ),
    );
  }
}
