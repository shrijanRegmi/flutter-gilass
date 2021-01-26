import 'package:drink/models/app_models/appuser_model.dart';
import 'package:drink/services/database/appuser_provider.dart';
import 'package:drink/viewmodels/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeVm extends ChangeNotifier {
  final BuildContext context;
  WelcomeVm(this.context);

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _exerciseController = TextEditingController();
  var _dailyIntake = 0.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController get nameController => _nameController;
  TextEditingController get heightController => _heightController;
  TextEditingController get weightController => _weightController;
  TextEditingController get exerciseController => _exerciseController;
  double get dailyIntake => _dailyIntake;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  AppVm get appVm => Provider.of<AppVm>(context, listen: false);

  // onpressed hydrate
  onPressedHydrate() async {
    if (_nameController.text.trim() != '' &&
        _heightController.text.trim() != '' &&
        _weightController.text.trim() != '' &&
        _exerciseController.text.trim() != '') {
      _calculateDailyIntake();

      final _appUser = AppUser(
        name: _nameController.text.trim(),
        height: int.parse(_heightController.text.trim()),
        weight: int.parse(_weightController.text.trim()),
        exercise: int.parse(_exerciseController.text.trim()),
        targetWater: int.parse(_dailyIntake.toStringAsFixed(0)),
      );
      await AppUserProvider(appUser: _appUser).registerUser();
      notifyListeners();
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please fill up all the fields to continue.'),
        ),
      );
    }
  }

  // calculate daily intake
  _calculateDailyIntake() {
    final _weight = int.parse(_weightController.text.trim());
    final _exercise = int.parse(_exerciseController.text.trim());
    var _wtInPounds = _weight * 2.2;

    _dailyIntake = (2 / 3 * _wtInPounds + (_exercise / 30 * 12)) * 29.5735;
    notifyListeners();
  }
}
