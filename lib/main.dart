import 'package:drink/models/app_models/appuser_model.dart';
import 'package:drink/services/database/appuser_provider.dart';
import 'package:drink/wrapper.dart';
import 'package:drink/wrapper_builder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _dir = await getApplicationDocumentsDirectory();
  Hive.init(_dir.path);
  await Hive.openBox('user');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppUser>.value(
      value: AppUserProvider().user,
      child: WrapperBuilder(
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
      ),
    );
  }
}
