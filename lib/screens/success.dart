import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 33, 35),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 140),
              child: Image.asset(
                'assets/Green-Tick-PNG-Pic.png',
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 25),
            Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  'Thank You !',
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Your complaint has been registered',
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontStyle: FontStyle.normal,
                      fontSize: 20),
                )),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: SizedBox(
                height: 45,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ScreenHome()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 88, 88, 88) // Background color
                      ),
                  child: Text('Home'),
                  //   style: ButtonStyle(backgroundColor:),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
