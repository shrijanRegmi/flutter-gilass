import 'package:drink/models/app_models/appuser_model.dart';
import 'package:hive/hive.dart';

class AppUserProvider {
  final AppUser appUser;
  AppUserProvider({this.appUser});

  final _userBox = Hive.box('user');

  // register user details
  Future registerUser() async {
    try {
      await _userBox.put('user', appUser.toJson());
      print('Success: Registering user');
      return 'Success';
    } catch (e) {
      print(e);
      print('Error!!!: Registering user');
      return null;
    }
  }

  // delete user
  Future deleteUser() async {
    try {
      await _userBox.delete('user');

      print('Success: Deleting user');
      return 'Success';
    } catch (e) {
      print(e);
      print('Error!!!: Deleting user');
      return null;
    }
  }

  AppUser get user {
    return _userBox.get('user') == null
        ? null
        : AppUser.fromJson(_userBox.get('user'));
  }
}
