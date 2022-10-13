import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kajal/screens/home.dart';
import 'package:kajal/screens/signup.dart';
import 'package:kajal/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(
            'assets/47c806c201fe661d4119b074091e1558.webp',
          ),
          radius: 45,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenWelcome(),
        ),
      );
    });
  }

  Future<void> checkUserLoggedIn() async {
    //SharedPreferences.setMockInitialValues({});
    final _sp = await SharedPreferences.getInstance();

    final userloogedin = _sp.getBool(Key_name);
    if (userloogedin == null || userloogedin == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenHome(),
        ),
      );
    }
  }
}
