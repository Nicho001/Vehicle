import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajal/main.dart';
import 'package:kajal/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSignup extends StatefulWidget {
  ScreenSignup({Key? key}) : super(key: key);

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final numberController = TextEditingController();
  final pwdController = TextEditingController();
  Future save() async {
    final String apiEndpoint = 'https://great-wheels.herokuapp.com/signup';
    final Uri url = Uri.parse(apiEndpoint);
    print(nameController.text);
    print(mailController.text);
    print(numberController.text);
    print(pwdController.text);
    var res = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode({
          'username': nameController.text,
          'email': mailController.text,
          'number': numberController.text,
          'password': pwdController.text,
        }));

    if (res.statusCode == 200) {
      //print(res.body);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenLogin(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Account Already Exixts",
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Stack(children: [
              Container(child: Image.asset('assets/2.webp')),
              Column(
                children: [
                  SizedBox(
                    height: 330,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 230),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            nameController.selection = TextSelection(
                                baseOffset: value.length,
                                extentOffset: value.length);
                          });
                        },
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 0, 0, 0)),
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
                                  color: Color.fromARGB(255, 241, 241, 241)),
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Username',
                        ),
                        // onSaved: (value) {
                        //   setState(() {
                        //     user.username = value;
                        //   });
                        // },
                        validator: (value) {
                          if ((value!.isEmpty) && isSubmit) {
                            return 'Please enter name';
                          }
                        }),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 30),
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
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 0, 0, 0)),
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
                                  color: Color.fromARGB(255, 241, 241, 241)),
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
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 30),
                    child: TextFormField(
                        controller: numberController,
                        onChanged: (value) {
                          setState(() {
                            numberController.selection = TextSelection(
                                baseOffset: value.length,
                                extentOffset: value.length);
                            // numberController.text = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 0, 0, 0)),
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
                                  color: Color.fromARGB(255, 241, 241, 241)),
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Phone Number',
                        ),
                        // onSaved: (value) {
                        //   setState(() {
                        //     user.number = value;
                        //   });
                        // },
                        validator: (value) {
                          if ((value!.isEmpty) && isSubmit) {
                            return 'Please enter phone number';
                          } else if ((value.length != 10) && isSubmit) {
                            return 'Enter 10 digits';
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 30),
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
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 0, 0, 0)),
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
                                  color: Color.fromARGB(255, 241, 241, 241)),
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
                    height: 30,
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
                        'Sign Up',
                        style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Row(
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.lato(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ScreenLogin(),
                              ),
                            );
                          },
                          child: Text("Login",
                              style: GoogleFonts.lato(
                                  color: Color.fromARGB(255, 255, 106, 0),
                                  fontSize: 15)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
