import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType type;
  final TextCapitalization capitalization;

  InputField({
    this.controller,
    this.title,
    this.type = TextInputType.text,
    this.capitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.black12,
            offset: Offset(1.0, 1.0),
          ),
        ],
        color: ThemeData().canvasColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '$title',
        ),
      ),
    );
  }
}
