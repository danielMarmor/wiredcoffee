// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveStringToStorage(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(key);
      return;
    }
    await prefs.setString(key, value);
  }

  Future<String?> getStringFromStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value;
  }
}
