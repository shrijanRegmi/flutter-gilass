import 'dart:math';

import 'package:drink/viewmodels/app_vm.dart';
import 'package:drink/views/widgets/home_widgets/goals.dart';
import 'package:flutter/material.dart';

class PercentageOverview extends StatelessWidget {
  final AppVm vm;
  PercentageOverview(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _headerBuilder(),
        // SizedBox(
        //   height: 10.0,
        // ),
        Expanded(
          child: Goals(min(vm.goalValue, 100)),
        ),
      ],
    );
  }

  Widget _headerBuilder() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Today',
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
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _timeBuilder('08:30'),
            SizedBox(
              width: 10.0,
            ),
            _timeBuilder('20:00'),
          ],
        ),
      ],
    );
  }

  Widget _timeBuilder(final String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color(0xffeef7fc),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        '$title',
      ),
    );
  }
}
