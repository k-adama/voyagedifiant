import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  LocalStorage._();

  static LocalStorage? _localStorage;

  static LocalStorage instance = LocalStorage._();

  static Future<LocalStorage> getInstance() async {
    if (_localStorage == null) {
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _localStorage!;
  }

  static Future<SharedPreferences> getSharedPreferences() async {
    if (_preferences == null) {
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _preferences!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

String? getCurrentLanguage() {
  return _preferences?.getString('language');
}

  Future<void> getLanguage(String? language) async {
    if (_preferences != null) {
      await _preferences!
          .setString('language', language ?? '');
    }
  }


  void logout() {
  }
}
