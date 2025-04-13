import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyagedifiant/core/constants/auth.constant.dart';

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

  Future<void> setToken(String? token) async {
    if (_preferences != null) {
      await _preferences!.setString(AuthConstant.keyToken, token ?? '');
    }
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  Future<void> setUserId(int value) async {
    await _preferences?.setInt(AuthConstant.userIdKey, value);
  }

  Future<String?> getToken() async {
    return _preferences?.getString(AuthConstant.keyToken);
  }

  Future<bool?> getBool(String key) async {
    return _preferences?.getBool(key);
  }

  Future<int?> getUserId() async {
    return _preferences?.getInt(AuthConstant.userIdKey);
  }

  String? getCurrentLanguage() {
    return _preferences?.getString('language');
  }

  Future<void> getLanguage(String? language) async {
    if (_preferences != null) {
      await _preferences!.setString('language', language ?? '');
    }
  }

//logout
  Future<void> removeToken() async {
    await _preferences?.remove(AuthConstant.keyToken);
  }

  Future<void> removeBool(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> removeUserId(String key) async {
    await _preferences?.remove(key);
  }

  void logout() {}
}
