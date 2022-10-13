import 'package:flutter/material.dart';
//import 'package:selfout/screens/favourites.dart';
import 'package:kajal/screens/home.dart';
import 'package:kajal/screens/signup.dart';
import 'package:kajal/screens/splash.dart';
import 'package:flutter/services.dart';
import 'package:kajal/screens/welcome.dart';

String kadayudeperu = '';
String place = '';
String category = '';
const Key_name = 'UserLoggedIn';
String nini = '';
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 33, 33, 35),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Sample',
      home: ScreenSplash(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
