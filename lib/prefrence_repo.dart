import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  final SharedPreferences sharedPreferences;

  PreferencesRepository({required this.sharedPreferences});

  Future<void> saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return sharedPreferences.getBool(key);
  }
}
