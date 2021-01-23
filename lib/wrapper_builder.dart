import 'package:drink/viewmodels/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperBuilder extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  WrapperBuilder({this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppVm>(
          create: (context) => AppVm(),
        ),
      ],
      child: builder(context),
    );
  }
}
