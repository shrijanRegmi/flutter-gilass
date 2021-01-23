import 'package:flutter/material.dart';

class FilledBtn extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color bgColor;
  FilledBtn({
    this.title,
    this.onPressed,
    this.bgColor = const Color(0xff74d5df),
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: onPressed ?? () {},
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          '$title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
