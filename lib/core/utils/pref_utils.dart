//ignore: unused_import
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
    return;
  }

  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
    // await FirebaseServices.handleLogOut();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  static Future<void> setDownloadedDocId(List<String> value) {
    return _sharedPreferences!.setStringList('downloadedDocIds', value);
  }

  static List<String> getDownloadedDocId() {
    return _sharedPreferences?.getStringList('downloadedDocIds') ?? <String>[];
  }

  static Future<void> setIsNewUser(bool value) {
    return _sharedPreferences!.setBool('isNew', value);
  }

  static bool getIsNewUser() {
    return _sharedPreferences?.getBool('isNew') ?? true;
  }

  static Future<void> setRole(String value) {
    return _sharedPreferences!.setString('role', value);
  }

  static String getRole() {
    return _sharedPreferences?.getString('role') ?? '';
  }

  static Future<void> setId(String value) {
    return _sharedPreferences!.setString('id', value);
  }

  static String getId() {
    return _sharedPreferences?.getString('id') ?? '';
  }

  static Future<void> setUserName(String value) {
    return _sharedPreferences!.setString('userName', value);
  }

  static String getUserName() {
    return _sharedPreferences?.getString('userName') ?? '';
  }

  static Future<void> setUserEmail(String value) {
    return _sharedPreferences!.setString('userEmail', value);
  }

  static String getUserEmail() {
    return _sharedPreferences?.getString('userEmail') ?? '';
  }

  static Future<void> setGender(String value) {
    return _sharedPreferences!.setString('gender', value);
  }

  static String getUserGender() {
    return _sharedPreferences?.getString('gender') ?? '';
  }

  static Future<void> setCountry(String value) {
    return _sharedPreferences!.setString('country', value);
  }

  static String getCountry() {
    return _sharedPreferences?.getString('country') ?? '';
  }

  static Future<void> setCity(String value) {
    return _sharedPreferences!.setString('city', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
