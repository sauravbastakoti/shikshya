import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferences _preferences;

  static const String _isLoggedIn = 'is_Logged_in';
  static const String _isFirstTime = 'is_first_time';
  static const String _token = 'token';
  //static const String _theme = 'theme';

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _preferences.getBool(_isLoggedIn) ?? true;
  set isLoggedIn(bool value) {
    _preferences.setBool(_isLoggedIn, value);
  }

  bool get isFirstTime => _preferences.getBool(_isFirstTime) ?? true; //getter
  set isFirstTime(bool value) {
    _preferences.setBool(_isFirstTime, value);
  }

  String? get token => _preferences.getString(_token);
  Future<bool> setToken(String? value) async {
    if (value != null) {
      return await _preferences.setString(_token, value);
    }
    return false;
  }

  Future<bool> clear() async {
    return await _preferences.clear();
  }

  // String get theme => _preferences.getString(_theme) ?? 'light';
  // set theme(String value) {
  //   _preferences.setString(_theme, value);
  // }
}
