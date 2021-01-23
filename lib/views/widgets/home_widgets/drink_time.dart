import 'package:drink/viewmodels/app_vm.dart';
import 'package:drink/views/widgets/common_widgets/progress.dart';
import 'package:flutter/material.dart';

class DrinkTime extends StatelessWidget {
  final AppVm vm;
  DrinkTime(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleBuilder(),
        SizedBox(
          height: 20.0,
        ),
        vm.drinkTimes.isEmpty
            ? _emptyBuilder()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vm.drinkTimes.length,
                itemBuilder: (context, index) {
                  final _drinkTime = vm.drinkTimes[index];
                  final _time =
                      DateTime.fromMillisecondsSinceEpoch(_drinkTime.time).hour;

                  return _progressBuilder(
                    "${_time > 12 ? (_time - 12).toString() : _time} ${_time < 12 ? 'AM' : 'PM'}",
                    _drinkTime.value,
                  );
                },
              ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _titleBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Drink Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        Row(
          children: [
            Text(
              'View All',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black26,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 13.0,
            )
          ],
        ),
      ],
    );
  }

  Widget _progressBuilder(final String title, final double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: Colors.black26,
              ),
            ),
            Text(
              '${value.toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.black26,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Progress(value),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget _emptyBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: Text(
        "You haven't drank water today !\nTap on the glass of water on the top right corner of the screen to drink.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
