import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/screens/home.dart';
import 'package:kajal/screens/navscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class vehicle {
  final String name;
  final String model;
  final String number;

  vehicle({required this.name, required this.model, required this.number});
}

//import 'package:selfout/editprofile.dart';
Future<String> sp1() async {
  final sp = await SharedPreferences.getInstance();
  String Username = sp.getString("Username")!;
  return Username;
}

Future<String> sp2() async {
  final sp = await SharedPreferences.getInstance();
  String UserId = sp.getString("UserId")!;
  return UserId;
}

// Future<String> sp3() async {
//   final sp = await SharedPreferences.getInstance();
//   String Email = sp.getString("Email")!;
//   return Email;
// }

// Future<String> sp4() async {
//   final sp = await SharedPreferences.getInstance();
//   String MobileNumber = sp.getString("Phonenumber")!;
//   return MobileNumber;
// }

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({
    Key? key,
  }) : super(key: key);
  @override
  State<ScreenProfile> createState() => ScreenProfileState();
}

class ScreenProfileState extends State<ScreenProfile> {
  List<vehicle> veh = [];
  void didChangeDependencies() {
    profilee();
    super.didChangeDependencies();
  }

  String modeee = '';
  Future delete() async {
    print(modeee);
    var url2 = "https://great-wheels.herokuapp.com/removeVehicle/$modeee";
    final Uri url = Uri.parse(url2);
    String htoken = await sp();
    var response2 = await http.delete(
      url,
      headers: {"X-Auth-Token": htoken},
    );
    if (response2.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenProfile(),
        ),
      );
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future profilee() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var url1 = "https://great-wheels.herokuapp.com/vehicleDetails";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"X-Auth-Token": htoken});
    if (response.statusCode == 200) {
      // setState(() {
      //   _isLoading = false;
      // });
      var responseData = json.decode(response.body);
      for (var u in responseData) {
        print(u);
        setState(() {
          veh.add(vehicle(
              name: u["make"], model: u["model"], number: u["vehicleNumber"]));
        });
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      throw Exception('Failed to load album');
    }
  }

  String n1 = "";
  String n2 = "";

  String n3 = "";
  String n4 = "";

  ScreenProfileState() {
    sp1().then((val) => setState(() {
          n1 = val;
        }));
    sp2().then((val) => setState(() {
          n2 = val;
        }));
    // sp3().then((val) => setState(() {
    //       n3 = val;
    //     }));
    // sp4().then((val) => setState(() {
    //       n4 = val;
    //     }));
  }

  // String n1 = await sp1();
  // Future<String> n2 = sp2();
  // Future<String> n3 = sp3();
  // Future<String> n4 = sp4();

  @override
  Widget build(BuildContext context) {
    Dialog leadDialog = Dialog(
      backgroundColor: Color.fromARGB(255, 73, 73, 73),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Color.fromARGB(255, 73, 73, 73),
        ),
        height: 90.0,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Do you really want to remove this vehicle',
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 15.0),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  TextButton(
                      onPressed: () {
                        delete();
                      },
                      child: Text('Yes')),
                  SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No')),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 1),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ScreenHome(),
                ),
              );
            },
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text(
              'Profile',
              style: GoogleFonts.poppins(),
            )),
        backgroundColor: Color.fromARGB(255, 33, 33, 35),
      ),
      body: Container(
        height: 1500,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Container(
                width: 300,
                //color: Color.fromARGB(1, 26, 56, 72),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.black,
                        // ),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/profile-user-round-black-icon-symbol-hd-png-11639594326nxsyvfnkg9.png'),
                            fit: BoxFit.cover),
                        //color: Colors.green,
                        //shape: BoxShape.circle,
                      ),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 145),
                          child: Text(
                            'UserId',
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0, left: 7),
                          child: Text(
                            n2,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Divider(
              color: Color.fromARGB(255, 197, 197, 197),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 70),
              child: Container(
                width: 300,
                color: Color.fromARGB(0, 255, 255, 255),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.black,
                        // ),
                        image: DecorationImage(
                            image:
                                AssetImage('assets/icons8-name-tag-100111.png'),
                            fit: BoxFit.cover),
                        //color: Colors.green,
                        //shape: BoxShape.circle,
                      ),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 80, left: 20),
                          child: Text(
                            n1,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Padding(
            //   padding: const EdgeInsets.only(right: 70),
            //   child: Container(
            //     width: 300,
            //     color: Color.fromARGB(0, 255, 255, 255),
            //     child: Row(
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             // border: Border.all(
            //             //   color: Colors.black,
            //             // ),
            //             image: DecorationImage(
            //                 image: AssetImage('assets/images/icons8-mail-90.png'),
            //                 fit: BoxFit.cover),
            //             //color: Colors.green,
            //             //shape: BoxShape.circle,
            //           ),
            //           width: 30,
            //           height: 30,
            //         ),
            //         SizedBox(width: 15),
            //         Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(right: 160),
            //               child: Text(
            //                 'E Mail',
            //                 style: GoogleFonts.poppins(
            //                     color: Color.fromARGB(255, 0, 0, 0),
            //                     //fontWeight: FontWeight.bold,
            //                     fontSize: 20),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(right: 0, left: 20),
            //               child: Text(
            //                 n3,
            //                 style: GoogleFonts.poppins(
            //                     color: Color.fromARGB(255, 0, 0, 0),
            //                     fontSize: 17),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(right: 70),
            //   child: Container(
            //     width: 300,
            //     color: Color.fromARGB(0, 255, 255, 255),
            //     child: Row(
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             // border: Border.all(
            //             //   color: Colors.black,
            //             // ),
            //             image: DecorationImage(
            //                 image: AssetImage(
            //                     'assets/images/icons8-iphone-x-96.png'),
            //                 fit: BoxFit.cover),
            //             //color: Colors.green,
            //             //shape: BoxShape.circle,
            //           ),
            //           width: 30,
            //           height: 30,
            //         ),
            //         SizedBox(width: 15),
            //         Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(right: 110),
            //               child: Text(
            //                 'Mobile',
            //                 style: GoogleFonts.poppins(
            //                     color: Color.fromARGB(255, 0, 0, 0),
            //                     //fontWeight: FontWeight.bold,
            //                     fontSize: 20),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(right: 100, left: 20),
            //               child: Text(
            //                 n4,
            //                 style: GoogleFonts.poppins(
            //                     color: Color.fromARGB(255, 0, 0, 0),
            //                     fontSize: 17),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Divider(
              color: Color.fromARGB(255, 112, 112, 112),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 110),
              child: Text("Your Vehicles",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),

            // SizedBox(
            //   height: 50,
            // ),
            Expanded(
              child: Container(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    return Container(
                      height: 75,
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            modeee = veh[index].model;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => leadDialog);
                        },
                        child: ListTile(
                          title: Text(
                            veh[index].name,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18),
                          ),
                          subtitle: Text(
                            veh[index].model,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13),
                          ),
                          // leading: CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: NetworkImage(wor[index].images),
                          // ),
                          trailing: Text(
                            veh[index].number,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: Color.fromARGB(255, 179, 179, 179),
                    );
                  },
                  itemCount: veh.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
