import 'package:drink/services/database/appuser_provider.dart';
import 'package:drink/views/screens/home/home_screen.dart';
import 'package:drink/views/screens/splash_screen.dart';
import 'package:drink/views/screens/welcome_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

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
    return _isLoading
        ? SplashScreen()
        : ValueListenableBuilder(
            valueListenable: Hive.box('user').listenable(),
            builder: (context, Box box, widget) {
              return box.get('user') == null
                  ? WelcomeScreen()
                  : Provider.value(
                      value: AppUserProvider().user,
                      child: HomeScreen(),
                    );
            },
          );
    // return SplashScreen();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
