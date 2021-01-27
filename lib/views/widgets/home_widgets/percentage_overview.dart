import 'dart:math';

import 'package:drink/models/app_models/appuser_model.dart';
import 'package:drink/viewmodels/app_vm.dart';
import 'package:drink/views/widgets/home_widgets/goals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PercentageOverview extends StatelessWidget {
  final AppVm vm;
  PercentageOverview(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headerBuilder(context),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Goals(min(vm.goalValue, 100)),
        ),
      ],
    );
  }

  Widget _headerBuilder(BuildContext context) {
    final _appUser = Provider.of<AppUser>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () => vm.showBottomSheet(_appUser),
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${vm.dateText}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _timeBuilder(final String title) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //     decoration: BoxDecoration(
  //       color: Color(0xffeef7fc),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     child: Text(
  //       '$title',
  //     ),
  //   );
  // }
}
