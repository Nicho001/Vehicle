import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:kajal/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> sp() async {
  final sp = await SharedPreferences.getInstance();
  String htoken = sp.getString("token")!;
  return htoken;
}

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final numberController = TextEditingController();
  Future save() async {
    final String apiEndpoint =
        'https://great-wheels.herokuapp.com/vehicleDetails';
    final Uri url = Uri.parse(apiEndpoint);
    print(brandController.text);
    print(modelController.text);
    print(numberController.text);
    String htoken = await sp();
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          "X-Auth-Token": htoken
        },
        body: json.encode({
          'make': brandController.text,
          'model': modelController.text,
          'vehicleNumber': numberController.text,
          'type': gender,
        }));

    if (res.statusCode == 200) {
      //print(res.body);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenHome(),
        ),
      );
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

  @override
  String gender = "Bike";
  bool isSubmit = false;
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 350, top: 20),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Image.asset('assets/usernew.jpg'),
                    SizedBox(
                      width: 20.0,
                      height: 10.0,
                    ),
                    Container(
                      //height: 495,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 241, 244, 245),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 0, top: 20),
                              child: Text(
                                'Vehicle Details',
                                style: GoogleFonts.lato(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                                controller: brandController,
                                onChanged: (value) {
                                  setState(() {
                                    brandController.selection = TextSelection(
                                        baseOffset: value.length,
                                        extentOffset: value.length);
                                  });
                                },
                                cursorColor: Colors.black,
                                style: GoogleFonts.lato(color: Colors.black),
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.black),
                                    labelText: 'Brand',
                                    fillColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          )),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                // onSaved: (value) {
                                //   setState(() {
                                //     Name = value;
                                //   });
                                // },
                                validator: (value) {
                                  if ((value!.isEmpty) && isSubmit) {
                                    return 'Please enter Brand Name';
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                                controller: modelController,
                                onChanged: (value) {
                                  setState(() {
                                    modelController.selection = TextSelection(
                                        baseOffset: value.length,
                                        extentOffset: value.length);
                                  });
                                },
                                cursorColor: Colors.black,
                                style: GoogleFonts.lato(color: Colors.black),
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.black),
                                    labelText: 'Model',
                                    fillColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                // onSaved: (value) {
                                //   setState(() {
                                //     Name = value;
                                //   });
                                // },
                                validator: (value) {
                                  if ((value!.isEmpty) && isSubmit) {
                                    return 'Please enter model';
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                                controller: numberController,
                                onChanged: (value) {
                                  setState(() {
                                    numberController.selection = TextSelection(
                                        baseOffset: value.length,
                                        extentOffset: value.length);
                                  });
                                },
                                cursorColor: Colors.black,
                                style: GoogleFonts.lato(color: Colors.black),
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.black),
                                    labelText: 'Vehicle Number',
                                    fillColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                // onSaved: (value) {
                                //   setState(() {
                                //     Name = value;
                                //   });
                                // },
                                validator: (value) {
                                  if ((value!.isEmpty) && isSubmit) {
                                    return 'Please enter Vehicle Model';
                                  }
                                }),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Container(
                                  height: 70,
                                  width: 140,
                                  child: ListTile(
                                    title: Text("Bike",
                                        style: GoogleFonts.lato(
                                            color: Colors.black, fontSize: 18)),
                                    leading: Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.black),
                                        value: " Bike",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: 200,
                                child: ListTile(
                                  title: Text("Scooter",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontSize: 18,
                                      )),
                                  leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.black),
                                      value: "Scooter",
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                save();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 203, 212, 215),
                                  side:
                                      BorderSide(color: Colors.white, width: 0),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                              child: Text(
                                "Add",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
