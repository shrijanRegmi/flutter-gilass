import 'package:drink/views/screens/splash_screen.dart';
import 'package:drink/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 5000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? SplashScreen() : WelcomeScreen();
    // return SplashScreen();
  }
}
