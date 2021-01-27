import 'dart:math';

import 'package:drink/models/app_models/appuser_model.dart';
import 'package:drink/models/app_models/drink_time_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppVm extends ChangeNotifier {
  final BuildContext context;
  AppVm(this.context);

  // Standard Values
  var _targetWater = 0;
  var _remainingWater = 0;
  var _waterToDrink = 200;
  var _minutesToNotify = 0;
  final _currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // Standard Values

  var _goalValue = 0.0;
  var _drinkTimes = <DrinkTime>[];
  var _isLoading = false;
  var _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _dateText = 'Today';

  double get goalValue => _goalValue;
  List<DrinkTime> get drinkTimes => _drinkTimes;
  int get remainingWater => _remainingWater;
  int get targetWater => _targetWater;
  int get waterToDrink => _waterToDrink;
  int get minutesToNotify => _minutesToNotify;
  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  String get dateText => _dateText;

  // init function
  onInit(final AppUser appUser) {
    initialize(appUser);
  }

  // initialize values
  initialize(final AppUser appUser) async {
    updateIsLoading(true);
    await _openBoxes([
      'drink_time_${_selectedDate.millisecondsSinceEpoch}',
      'goals_${_selectedDate.millisecondsSinceEpoch}'
    ]);

    final _goalBox = Hive.box('goals_${_selectedDate.millisecondsSinceEpoch}');
    final _drinkTimeBox =
        Hive.box('drink_time_${_selectedDate.millisecondsSinceEpoch}');

    _goalValue = _goalBox.get('goal') ?? 0;
    _drinkTimes =
        _drinkTimeBox.values.map((e) => DrinkTime.fromJson(e)).toList();
    _targetWater = appUser.targetWater;
    _remainingWater =
        max(_targetWater - (_goalValue / 100 * _targetWater).toInt(), 0);
    notifyListeners();
    updateIsLoading(false);
  }

  // open boxes
  Future<List<Box>> _openBoxes(final List<String> _boxesToOpen) async {
    try {
      var _boxes = <Box>[];

      for (var box in _boxesToOpen) {
        final _openedBox = await Hive.openBox(box);
        _boxes.add(_openedBox);
      }

      print('Success: Opening boxes $_boxesToOpen');
      return _boxes;
    } catch (e) {
      print('Error!!!: Opening boxes $_boxesToOpen');
      return null;
    }
  }

  // on water drink
  onWaterDrink(final double newGoalValue) async {
    updateGoalValue(newGoalValue);

    final _list = _drinkTimes;
    final _index = _list.indexWhere((element) =>
        DateTime.fromMillisecondsSinceEpoch(element.time).hour ==
            DateTime.now().hour &&
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(element.time))
                .inMinutes <
            2);
    if (_index != -1) {
      final _drinkTime = DrinkTime(
        time: _list[_index].time,
        value: min(_list[_index].value + 50, 100),
      );
      Hive.box('drink_time_${_selectedDate.millisecondsSinceEpoch}')
          .putAt(_index, _drinkTime.toJson());
      _list[_index] = _drinkTime;
    } else {
      final _drinkTime = DrinkTime(
        time: DateTime.now().millisecondsSinceEpoch,
        value: 50,
      );
      Hive.box('drink_time_${_selectedDate.millisecondsSinceEpoch}')
          .add(_drinkTime.toJson());
      _list.add(_drinkTime);
    }

    updateDrinkTimes(_list);
  }

  // update value of goalValue
  updateGoalValue(final double newVal) {
    if (_goalValue < 100) {
      _goalValue = newVal;
      Hive.box('goals_${_selectedDate.millisecondsSinceEpoch}')
          .put('goal', _goalValue);
      notifyListeners();
    }
  }

  // update value of drink times list
  updateDrinkTimes(final List<DrinkTime> newDrinkTimes) {
    _drinkTimes = newDrinkTimes;
    notifyListeners();
  }

  // update value of remaining
  updateRemainingWater(final int newVal) {
    if (_goalValue >= 100) {
      _remainingWater = 0;
      notifyListeners();
    } else {
      if (newVal >= 0) {
        _remainingWater = newVal;
        notifyListeners();
      }
    }
  }

  // update value of target water intake
  updateTargetValue(final double newVal) {
    _targetWater = int.parse('${newVal.toStringAsFixed(0)}');
    notifyListeners();
  }

  // update value of minutes to notify
  updateMinutesToNotify(final int newVal) {
    _minutesToNotify = newVal;
    notifyListeners();
  }

  // update value of loader
  updateIsLoading(final bool newVal) {
    _isLoading = newVal;
    notifyListeners();
  }

  // update value of selected date
  updateDate(final DateTime newDate) {
    _selectedDate = newDate;
    if (newDate == _currentDate) {
      _dateText = 'Today';
    } else {
      _dateText = 'Yesterday';
    }
    notifyListeners();
  }

  // show bottom sheet
  showBottomSheet(final AppUser appUser) async {
    final _prevDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(days: 1));
    final _selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Today'),
              onTap: () {
                Navigator.pop(context);
                updateDate(_selectedDate);
                initialize(appUser);
              },
            ),
            ListTile(
              title: Text('Yesterday'),
              onTap: () {
                Navigator.pop(context);
                updateDate(_prevDate);
                initialize(appUser);
              },
            ),
          ],
        );
      },
    );
  }
}
