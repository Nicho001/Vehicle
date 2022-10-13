//import 'dart:convert';

import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/screens/profile.dart';
import 'package:kajal/screens/recentcomplaints.dart';
import 'package:kajal/screens/signup.dart';
import 'package:kajal/screens/tyre.dart';
import 'package:kajal/screens/userdetails.dart';
import 'package:kajal/screens/water.dart';
import 'package:kajal/screens/workshop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'navscreen.dart';

class User {
  final String name;
  final String location;
  final String images;
  final String id;

  User(
      {required this.name,
      required this.location,
      required this.images,
      required this.id});
}

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class Favorit {
  final String name;
  final String images;
  final String location;

  Favorit({required this.name, required this.images, required this.location});
}

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  var activeIndex = 0;

  String dropdownvalue = 'Trivandrum';

  // List of items in our dropdown menu
  var items = [
    'Kochi',
    'Kozhikode',
    'Trivandrum',
  ];

  var images = [
    //'assets/images/offer1.jpg',
    'assets/offer2.jpg',
    // 'assets/images/offer3.jpg',
    'assets/offer4.jpg',
    'assets/offer6.jpg',
    'assets/offer5.jpg',
  ];
  late List<bool> isSelected;
  void initState() {
    isSelected = [true, false, false];
    super.initState();
  }

  // List<User> users = [];
  // Future save1() async {
  //   var url1 = "https://great-wheels.herokuapp.com/workshops/$place/$category";
  //   final Uri url = Uri.parse(url1);
  //   String htoken = await sp();
  //   var response = await http.get(url, headers: {"X-Auth-Token": htoken});
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     for (var u in responseData) {
  //       //print(u);
  //       setState(() {
  //         users.add(User(
  //             name: u["name"],
  //             location: u["location"],
  //             images: u["images"],
  //             id: u["_id"]));
  //       });
  //     }
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => ScreenWater(),
  //       ),
  //     );
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  // Future save2() async {
  //   var url1 = "https://great-wheels.herokuapp.com/shops";
  //   final Uri url = Uri.parse(url1);
  //   String htoken = await sp();
  //   var response = await http.get(url, headers: {"X-Auth-Token": htoken});
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     for (var u in responseData) {
  //       //print(u);
  //       setState(() {
  //         users.add(User(
  //             name: u["name"],
  //             location: u["location"],
  //             images: u["images"],
  //             id: u["_id"]));
  //       });
  //     }
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => ScreenTyre()),
  //     );
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  // Future save3() async {
  //   var url1 = "https://great-wheels.herokuapp.com/shops";
  //   final Uri url = Uri.parse(url1);
  //   String htoken = await sp();
  //   var response = await http.get(url, headers: {"X-Auth-Token": htoken});
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     for (var u in responseData) {
  //       //print(u);
  //       setState(() {
  //         users.add(User(
  //             name: u["name"],
  //             location: u["location"],
  //             images: u["images"],
  //             id: u["_id"]));
  //       });
  //     }
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => ScreenWorkshop(),
  //       ),
  //     );
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  final _list = [
    'Kochi',
    'Thiruvananthapuram',
    'Kannur',
    'Thrissur',
    'Palakkad',
    'Kozhikode',
    'Alappuzha',
    'Kollam',
    'Malappuram',
    'Kottyam',
    'Idukki',
    'Pathanamthitta',
    'Kasargod'
  ];
  void didChangeDependencies() {
    recent();
    super.didChangeDependencies();
  }

  bool helo = false;
  bool h1 = false;
  bool h2 = false;
  bool h3 = false;
  bool h4 = false;
  bool h5 = false;
  List<Favorit> fav = [];
  List<Favorit> fav1 = [];
  bool _isLoading = true;
  Future recent() async {
    setState(() {
      _isLoading = true;
    });
    var url1 = "https://great-wheels.herokuapp.com/recent/complaints";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var responseData = json.decode(response.body);
      //print('Hello');
      //print(responseData);

      //print('Hello');
      for (var u in responseData) {
        setState(() {
          print('vadaaa');
          fav.add(Favorit(
              name: u["shopName"],
              images: u["shopImage"],
              location: u["shopLocation"]));
        });
      }

      //print(fav[2].name);
      // print(fav[4].name);
      //print(fav[4].name);
      if (fav.length == 0) {
        print('hellooo');
        h1 = true;
        h2 = true;
        h3 = true;
        h4 = true;
        h5 = true;
      }
      // if (fav.length == 1) {
      //   h1 = false;
      //   h2 = true;
      //   h3 = true;
      //   h4 = true;
      //   h5 = true;
      // }
      // if (fav.length == 2) {
      //   h1 = false;
      //   h2 = false;
      //   h3 = true;
      //   h4 = true;
      //   h5 = true;
      // }
      // if (fav.length == 3) {
      //   h1 = false;
      //   h2 = false;
      //   h3 = false;
      //   h4 = true;
      //   h5 = true;
      // }
      // if (fav.length == 4) {
      //   h1 = false;
      //   h2 = false;
      //   h3 = false;
      //   h4 = false;
      //   h5 = true;
      // }
      // if (fav.length == 5) {
      //   h1 = false;
      //   h2 = false;
      //   h3 = false;
      //   h4 = false;
      //   h5 = false;
      // }
      // while (ll < 5) {
      //   setState(() {
      //     helo = true;
      //     fav1.add(Favorit(name: "", images: "", location: ""));
      //     ll = ll + 1;
      //   });

      //   // if (fav.length == 5) {
      //   //   setState(() {
      //   //     yes = true;
      //   //   });
      //   // }
      // }
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Text(
            'Great Wheels',
            style: GoogleFonts.poppins(
                fontSize: 25,
                //fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        )),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 33, 33, 35),
                  Color.fromARGB(255, 33, 33, 35),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // stops: [
            //   0.1,
            //   0.4,
            //   0.6,
            //   0.9,
            // ],
            colors: [
              // Colors.yellow,

              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
              //Colors.teal,
            ],
          )),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              //
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20)),
              //   child: ToggleButtons(
              //     borderRadius: BorderRadius.circular(20),
              //     fillColor: Color.fromARGB(255, 224, 240, 245),
              //     children: <Widget>[
              //       Container(
              //           width: 100,
              //           child: Center(
              //               child: Text(
              //             'Kochi',
              //             style: GoogleFonts.lato(
              //               color: Color.fromARGB(255, 0, 0, 0),
              //               fontSize: 20,
              //               //fontWeight: FontWeight.bold
              //             ),
              //           ))),
              //       Container(
              //           width: 110,
              //           child: Center(
              //               child: Text(
              //             'Trivandrum',
              //             style: GoogleFonts.lato(
              //               color: Color.fromARGB(255, 0, 0, 0),
              //               fontSize: 20,
              //               //fontWeight: FontWeight.bold
              //             ),
              //           ))),
              //       Container(
              //           width: 100,
              //           child: Center(
              //               child: Text(
              //             'Kannur',
              //             style: GoogleFonts.lato(
              //               color: Color.fromARGB(255, 0, 0, 0),
              //               fontSize: 20,
              //               //fontWeight: FontWeight.bold
              //             ),
              //           ))),
              //     ],
              //     onPressed: (int index) {
              //       setState(() {
              //         for (int buttonIndex = 0;
              //             buttonIndex < isSelected.length;
              //             buttonIndex++) {
              //           if (buttonIndex == index) {
              //             isSelected[buttonIndex] = true;
              //           } else {
              //             isSelected[buttonIndex] = false;
              //           }
              //         }
              //       });
              //     },
              //     isSelected: isSelected,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  height: 55,
                  //width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: DropdownButtonFormField(
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20))),
                    hint: Text(
                      'Select Location',
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    items: _list.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        place = value.toString();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Recent Shops',
                        style: GoogleFonts.lato(
                            // fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Screencera(),
                            ),
                          );
                        },
                        child: Text(
                          'see all',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(198, 108, 108, 108)),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 15),
                child: Container(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // if (fav[0].name == 'Lulu') {
                          //   namee = fav[0].name;
                          //   iid = '62c530526f837e4f010c695b';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c530526f837e4f010c695b'),
                          //     ),
                          //   );
                          // }
                          // if (fav[0].name == 'Ishopi') {
                          //   namee = fav[0].name;
                          //   iid = '62c531026f837e4f010c695e';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c531026f837e4f010c695e'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          width: 80,
                          alignment: Alignment.topCenter,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, left: 15, right: 15, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    // ),
                                    image: DecorationImage(
                                        image: NetworkImage(fav.length <= 0
                                            ? ''
                                            : (_isLoading
                                                ? ' '
                                                : fav[0].images)),
                                        fit: BoxFit.fill),
                                    //color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0, top: 7),
                                child: Container(
                                  //color: Colors.blue,
                                  //alignment: Alignment.,
                                  child: Text(
                                    fav.length <= 0
                                        ? ''
                                        : (_isLoading ? ' ' : fav[0].name),
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // if (fav[1].name == 'Lulu') {
                          //   namee = fav[1].name;
                          //   iid = '62c530526f837e4f010c695b';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c530526f837e4f010c695b'),
                          //     ),
                          //   );
                          // }
                          // if (fav[1].name == 'Ishopi') {
                          //   namee = fav[1].name;
                          //   iid = '62c531026f837e4f010c695e';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c531026f837e4f010c695e'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, left: 15, right: 15, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(fav.length <= 1
                                            ? ''
                                            : (_isLoading
                                                ? ' '
                                                : fav[1].images)),
                                        fit: BoxFit.cover),
                                    //color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                  //color: Colors.blue,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    fav.length <= 1
                                        ? ''
                                        : (_isLoading ? ' ' : fav[1].name),
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // if (fav[2].name == 'Lulu') {
                          //   setState(() {
                          //     //print(fav[2].name);
                          //     namee = fav[2].name;
                          //     iid = '62c530526f837e4f010c695b';
                          //   });

                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c530526f837e4f010c695b'),
                          //     ),
                          //   );
                          // }
                          // if (fav[2].name == 'Ishopi') {
                          //   namee = fav[2].name;
                          //   iid = '62c531026f837e4f010c695e';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c531026f837e4f010c695e'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, left: 15, right: 15, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(fav.length <= 2
                                            ? ''
                                            : (_isLoading
                                                ? ' '
                                                : fav[2].images)),
                                        fit: BoxFit.cover),
                                    //color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                  //color: Colors.blue,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    fav.length <= 2
                                        ? ''
                                        : (_isLoading ? ' ' : fav[2].name),
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // if (fav[3].name == 'Lulu') {
                          //   namee = fav[3].name;
                          //   iid = '62c530526f837e4f010c695b';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c530526f837e4f010c695b'),
                          //     ),
                          //   );
                          // }
                          // if (fav[3].name == 'Ishopi') {
                          //   namee = fav[3].name;
                          //   iid = '62c531026f837e4f010c695e';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c531026f837e4f010c695e'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, left: 15, right: 15, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(fav.length <= 3
                                            ? ''
                                            : (_isLoading
                                                ? ' '
                                                : fav[3].images)),
                                        fit: BoxFit.fill),
                                    //color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                  //color: Colors.blue,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    fav.length <= 3
                                        ? ''
                                        : (_isLoading ? ' ' : fav[3].name),
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // if (fav[4].name == 'Lulu') {
                          //   namee = fav[4].name;
                          //   iid = '62c530526f837e4f010c695b';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c530526f837e4f010c695b'),
                          //     ),
                          //   );
                          // }
                          // if (fav[4].name == 'Ishopi') {
                          //   namee = fav[4].name;
                          //   iid = '62c531026f837e4f010c695e';
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Screencera(
                          //           title:
                          //               '62c531026f837e4f010c695e'),
                          //     ),
                          //   );
                          // }
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, left: 15, right: 15, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(fav.length <= 4
                                            ? ''
                                            : (_isLoading
                                                ? ' '
                                                : fav[4].images)),
                                        fit: BoxFit.fill),
                                    //color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                  //color: Colors.blue,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    fav.length <= 4
                                        ? ''
                                        : (_isLoading ? ' ' : fav[4].name),
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Offers',
                    style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Container(
                // color: Color.fromARGB(255, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index, realindex) {
                          final im = images[index];

                          return buildImage(im, index);
                        },
                        options: CarouselOptions(
                          //aspectRatio: 2 / 1,

                          // enlargeCenterPage: true,

                          autoPlayInterval: Duration(seconds: 3),

                          autoPlayCurve: Curves.easeIn,

                          height: 140,

                          enableInfiniteScroll: true,

                          autoPlay: true,

                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    buildIndicator(activeIndex),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                height: 215,
                //185
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, top: 15),
                        child: Text(
                          'Services',
                          style: GoogleFonts.lato(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 0, top: 8),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (isSelected[0] == true) {
                                      //   place = 'Kochi';
                                      // }
                                      // if (isSelected[1] == true) {
                                      //   place = 'thiruvananthapuram';
                                      // }
                                      // if (isSelected[2] == true) {
                                      //   place = 'Kannur';
                                      // }
                                      category = 'Water Service';
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => ScreenWater(),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 25,
                                          // ),
                                          TextButton(
                                              onPressed: () {
                                                // if (isSelected[0] == true) {
                                                //   place = 'Kochi';
                                                // }
                                                // if (isSelected[1] == true) {
                                                //   place = 'thiruvananthapuram';
                                                // }
                                                // if (isSelected[2] == true) {
                                                //   place = 'Kannur';
                                                // }
                                                category = 'Water Service';
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenWater(),
                                                ));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                    'assets/icons8-car-cleaning-50.png',
                                                    fit: BoxFit.contain),
                                              )),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          Text(
                                            "Water Service",
                                            style: GoogleFonts.lato(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              //fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (isSelected[0] == true) {
                                      //   place = 'Kochi';
                                      // }
                                      // if (isSelected[1] == true) {
                                      //   place = 'thiruvananthapuram';
                                      // }
                                      // if (isSelected[2] == true) {
                                      //   place = 'Kannur';
                                      // }
                                      category = 'Tyre Services';
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ScreenTyre(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          TextButton(
                                            onPressed: () {
                                              // if (isSelected[0] == true) {
                                              //   place = 'Kochi';
                                              // }
                                              // if (isSelected[1] == true) {
                                              //   place = 'thiruvananthapuram';
                                              // }
                                              // if (isSelected[2] == true) {
                                              //   place = 'Kannur';
                                              // }
                                              category = 'Tyre Service';
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenTyre(),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                    'assets/icons8-tyre-64.png',
                                                    fit: BoxFit.contain)),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          Text(
                                            "Tyre Services ",
                                            style: GoogleFonts.lato(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              //fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 20, top: 8),
                            child: GestureDetector(
                              onTap: () {
                                // if (isSelected[0] == true) {
                                //   place = 'Kochi';
                                // }
                                // if (isSelected[1] == true) {
                                //   place = 'thiruvananthapuram';
                                // }
                                // if (isSelected[2] == true) {
                                //   place = 'Kannur';
                                // }
                                category = 'Full Service';
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ScreenWorkshop(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          TextButton(
                                              onPressed: () {
                                                // if (isSelected[0] == true) {
                                                //   place = 'Kochi';
                                                // }
                                                // if (isSelected[1] == true) {
                                                //   place = 'thiruvananthapuram';
                                                // }
                                                // if (isSelected[2] == true) {
                                                //   place = 'Kannur';
                                                // }
                                                category = 'Full Service';
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScreenWorkshop(),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                    'assets/icons8-mechanic-64.png',
                                                    fit: BoxFit.contain),
                                              )),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          Text(
                                            "Mechanic",
                                            style: GoogleFonts.lato(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              //fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //             left: 20, right: 8, bottom: 0),
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             if (isSelected[0] == true) {
                    //               place = 'Kochi';
                    //             }
                    //             if (isSelected[1] == true) {
                    //               place = 'thiruvananthapuram';
                    //             }
                    //             if (isSelected[2] == true) {
                    //               place = 'Kannur';
                    //             }
                    //             category = 'Full Service';
                    //             Navigator.of(context).pushReplacement(
                    //               MaterialPageRoute(
                    //                 builder: (context) => ScreenWorkshop(),
                    //               ),
                    //             );
                    //           },
                    //           child: Container(
                    //             height: 160,
                    //             width: 190,
                    //             child: Column(
                    //               children: [
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     color:
                    //                         Color.fromARGB(255, 224, 240, 245),
                    //                   ),
                    //                   height: 160,
                    //                   width: 190,
                    //                   child: Column(
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 20,
                    //                       ),
                    //                       TextButton(
                    //                           onPressed: () {
                    //                             if (isSelected[0] == true) {
                    //                               place = 'Kochi';
                    //                             }
                    //                             if (isSelected[1] == true) {
                    //                               place = 'thiruvananthapuram';
                    //                             }
                    //                             if (isSelected[2] == true) {
                    //                               place = 'Kannur';
                    //                             }
                    //                             category = 'Full Service';
                    //                             Navigator.of(context)
                    //                                 .pushReplacement(
                    //                               MaterialPageRoute(
                    //                                 builder: (context) =>
                    //                                     ScreenWorkshop(),
                    //                               ),
                    //                             );
                    //                           },
                    //                           child: ClipRRect(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20),
                    //                             child: Image.asset(
                    //                                 'assets/icons8-mechanic-64.png',
                    //                                 fit: BoxFit.contain),
                    //                           )),
                    //                       SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Text(
                    //                         "Mechanic",
                    //                         style: GoogleFonts.lato(
                    //                           color:
                    //                               Color.fromARGB(255, 0, 0, 0),
                    //                           fontSize: 20,
                    //                           //fontWeight: FontWeight.bold
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //             left: 8, right: 20, bottom: 0),
                    //         child: GestureDetector(
                    //           onTap: () {},
                    //           child: Container(
                    //             height: 160,
                    //             width: 190,
                    //             child: Column(
                    //               children: [
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     color:
                    //                         Color.fromARGB(255, 224, 240, 245),
                    //                   ),
                    //                   height: 160,
                    //                   width: 190,
                    //                   child: Column(
                    //                     children: [
                    //                       SizedBox(height: 25),
                    //                       TextButton(
                    //                         onPressed: () {},
                    //                         child: ClipRRect(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(20),
                    //                             child: Image.asset(
                    //                                 'assets/icons8-dirt-bike-50.png',
                    //                                 fit: BoxFit.contain)),
                    //                       ),
                    //                       SizedBox(height: 15),
                    //                       Text(
                    //                         "Other Services",
                    //                         style: GoogleFonts.lato(
                    //                           color:
                    //                               Color.fromARGB(255, 0, 0, 0),
                    //                           fontSize: 20,
                    //                           //fontWeight: FontWeight.bold
                    //                         ),
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6,
          color: Color.fromARGB(255, 33, 33, 35),
          //Color.fromARGB(200, 255, 255, 255),,
          child: Row(
            children: [
              Expanded(
                child: Container(
                    height: 50,
                    width: 100,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenProfile(),
                          ));
                        },
                        icon: Icon(
                          color: Color.fromARGB(255, 255, 255, 255),
                          Icons.person,
                          size: 25,
                        ))),
              ),
              SizedBox(width: 220),
              Expanded(
                child: Container(
                    height: 50,
                    width: 100,
                    child: IconButton(
                        onPressed: () {
                          signout(context);
                        },
                        icon: Icon(
                          color: Color.fromARGB(255, 255, 255, 255),
                          Icons.logout,
                          size: 25,
                        ))),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetails(),
            ));
          },
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          child: Icon(
            Icons.add,
            color: Color.fromARGB(255, 255, 255, 255),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget buildImage(String im, int index) {
  return Container(
    width: 320,
    height: 100,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(im, fit: BoxFit.cover)),
  );
}

Widget buildIndicator(int activeIndex) {
  return AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 4,
    effect: ScrollingDotsEffect(
        radius: 5,
        dotWidth: 5,
        dotHeight: 5,
        dotColor: Color.fromARGB(255, 138, 137, 137),
        activeDotColor: Color.fromARGB(255, 0, 0, 0)),
  );
}

signout(BuildContext context) async {
  final _sp = await SharedPreferences.getInstance();
  await _sp.clear();

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ScreenSignup()),
      (route) => false);
}
