import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/screens/home.dart';
import 'package:kajal/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:kajal/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final mailController = TextEditingController();
  final pwdController = TextEditingController();
  Future save() async {
    final String apiEndpoint = 'https://great-wheels.herokuapp.com/signin';
    final Uri url = Uri.parse(apiEndpoint);
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Charset': 'utf-8'
        },
        body: json.encode(
            {'email': mailController.text, 'password': pwdController.text}));

    if (res.statusCode == 200) {
      var u = json.decode(res.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString("token", u["token"]);
      await sp.setString('Username', u["username"]);
      // await sp.setString('Phonenumber', u["number"]);
      await sp.setString('UserId', u["_id"]);
      // await sp.setString('Email', u["email"]);
      login(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Invalid Username or Password",
          style: GoogleFonts.lato(),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ));
    }
  }

  final formkey = GlobalKey<FormState>();
  bool isSubmit = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                        'assets/63773689c5405621be6336d5e91b5b61.jpg')),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 230),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                // SizedBox(
                //   height: 5,
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 0),
                  child: TextFormField(
                      controller: mailController,
                      onChanged: (value) {
                        setState(() {
                          mailController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                          //mailController.text = value;
                        });
                      },
                      style:
                          GoogleFonts.lato(color: Color.fromARGB(255, 0, 0, 0)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 241, 241, 241),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 132, 132, 132)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Email-id',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.email = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter email';
                        } else if ((!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) &&
                            isSubmit) {
                          return 'Enter Valid email';
                        }
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                  child: TextFormField(
                      controller: pwdController,
                      onChanged: (value) {
                        setState(() {
                          pwdController.selection = TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length);
                          // pwdController.text = value;
                        });
                      },
                      obscureText: true,
                      style:
                          GoogleFonts.lato(color: Color.fromARGB(255, 0, 0, 0)),
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 241, 241, 241),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 132, 132, 132)),
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Password',
                      ),
                      // onSaved: (value) {
                      //   setState(() {
                      //     user.password = value;
                      //   });
                      // },
                      validator: (value) {
                        if ((value!.isEmpty) && isSubmit) {
                          return 'Please enter password';
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black, fixedSize: Size(150, 50)),
                    onPressed: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => ScreenLogin(),
                      //   ),
                      // );
                      setState(() {
                        isSubmit = true;
                      });

                      if (formkey.currentState!.validate()) {
                        save();
                        formkey.currentState!.save();
                      }
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: Row(
                    children: [
                      Text(
                        "Dont have an account?",
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ScreenSignup(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.lato(
                              color: Color.fromARGB(255, 255, 106, 0),
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

login(BuildContext context) async {
  final _sp = await SharedPreferences.getInstance();
  await _sp.setBool(Key_name, true);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => ScreenHome(),
    ),
  );
}
