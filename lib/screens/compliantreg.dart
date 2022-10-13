import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kajal/screens/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

// class vehicle {
//   final String name;
//   vehicle({required this.name,})
// }

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class complaint extends StatefulWidget {
  complaint({Key? key}) : super(key: key);

  @override
  State<complaint> createState() => _complaintState();
}

class _complaintState extends State<complaint> {
  //List<vehicle> veh = [];
  String ssname = '';
  List names = [];
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
          names.add((u["model"]));
        });
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      throw Exception('Failed to load album');
    }
  }

  String name = "";
  String image = "";
  String description = "";
  int ratings = 0;
  String phone = "";
  String id = '';

  void initState() {
    workshop1();
    super.initState();
  }

  void didChangeDependencies() {
    workshop1();
    profilee();
    super.didChangeDependencies();
  }

  TextEditingController complaintController = TextEditingController();
  bool _isLoading = false;
  Future complaint() async {
    final String apiEndpoint =
        'https://great-wheels.herokuapp.com/complaint/register/$id';
    print(id);
    print(complaintController.text);
    print(ssname);
    final Uri url = Uri.parse(apiEndpoint);
    String htoken = await sp();
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          "X-Auth-Token": htoken
        },
        body: json.encode({
          'complaint': complaintController.text,
          'model': ssname,
        }));
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  Future workshop1() async {
    setState(() {
      _isLoading = true;
    });
    var url1 = "https://great-wheels.herokuapp.com/workshop/$nini";
    final Uri url = Uri.parse(url1);
    String htoken = await sp();
    var response = await http.get(url, headers: {"x-auth-token": htoken});
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      setState(() {
        _isLoading = false;
        name = responseData["name"];
        image = responseData["image"];
        description = responseData["location"];
        //ratings = responseData["rating"];
        phone = responseData["number"];
        id = responseData["_id"];
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 33, 33, 35),
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Text(
                name,
                style: GoogleFonts.lato(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.network(image),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 30),
                        //   child: Row(
                        //     children: [
                        //       Text("Rating: ${ratings.toString()}",
                        //           style: TextStyle(fontSize: 20)),
                        //       SizedBox(
                        //         width: 10.0,
                        //       ),
                        //       // Icon(
                        //       //   Icons.star,
                        //       //   color: Colors.orange,
                        //       // ),
                        //       // Icon(
                        //       //   Icons.star,
                        //       //   color: Colors.orange,
                        //       // ),
                        //       // Icon(
                        //       //   Icons.star,
                        //       //   color: Colors.orange,
                        //       // ),
                        //       // Icon(Icons.star, color: Colors.orange),
                        //       // Icon(Icons.star_half, color: Colors.orange),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: 30.0,
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Text(description,
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20)),
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android,
                                size: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(phone,
                                  style: GoogleFonts.lato(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            controller: complaintController,
                            onChanged: (value) {
                              setState(() {
                                complaintController.text = value;
                                complaintController.selection = TextSelection(
                                    baseOffset: value.length,
                                    extentOffset: value.length);
                              });
                            },
                            maxLines: null,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            decoration: InputDecoration(
                                hintText: 'Complaint Description',
                                hintStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 233, 228, 228)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 233, 228, 228)),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
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
                                        width: 1,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(20))),
                              hint: Text(
                                'Select your vehicle',
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              items: names.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  ssname = value.toString();
                                });
                                print(value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            complaint();
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 76, 76, 76),
                              fixedSize: Size(150, 50)),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
