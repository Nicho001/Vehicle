import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/screens/signup.dart';

import 'login.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({Key? key}) : super(key: key);

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(child: Image.asset('assets/1.jpg')),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      'Great Wheels',
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      'Rides \njust got better',
                      style: GoogleFonts.raleway(
                          // fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          //fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ScreenSignup(),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 0, 0, 0)),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.lato(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ScreenLogin(),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                'Login',
                                style: GoogleFonts.lato(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
