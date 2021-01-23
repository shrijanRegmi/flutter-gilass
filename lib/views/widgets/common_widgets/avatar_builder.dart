import 'package:flutter/material.dart';

class AvatarBuilder extends StatelessWidget {
  final String img;
  final double radius;

  AvatarBuilder({this.img, this.radius = 20.0});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: radius,
    );
  }
}
