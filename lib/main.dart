import 'package:drink/wrapper.dart';
import 'package:drink/wrapper_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperBuilder(
      builder: (context) {
        return MaterialApp(
          title: 'Gilass',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Nunito',
          ),
          home: Wrapper(),
        );
      },
    );
  }
}
