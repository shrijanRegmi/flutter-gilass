import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: max(MediaQuery.of(context).size.width / 2 + 100, 240.0),
                height: max(MediaQuery.of(context).size.width / 2 + 100, 240.0),
                child: Lottie.asset(
                  'assets/lottie/water-loader.json',
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController
                      ..duration = Duration(milliseconds: 4500)
                      ..repeat();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'GILASS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff74d5df),
                        radius: 6.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
