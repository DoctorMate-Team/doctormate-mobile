import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    @required String? key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    if (value is List<String>) {
      return await sharedPreferences!.setStringList(key!, value);
    }

    return await sharedPreferences!.setDouble(key!, value);
  }

  static dynamic getData({@required String? key}) {
    return sharedPreferences!.get(key!);
  }

  // Convenience methods for common operations
  static Future<bool> setString(String key, String value) async {
    return await sharedPreferences!.setString(key, value);
  }

  static String? getString(String key) {
    return sharedPreferences!.getString(key);
  }

  static Future<bool> setInt(String key, int value) async {
    return await sharedPreferences!.setInt(key, value);
  }

  static int? getInt(String key) {
    return sharedPreferences!.getInt(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBool(String key) {
    return sharedPreferences!.getBool(key);
  }

  static Future<bool> remove(String key) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> removeData({@required String? key}) async {
    return await sharedPreferences!.remove(key!);
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredValue(String key, dynamic value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    String stringValue;

    // تحويل القيمة لأي نوع إلى String
    if (value is String) {
      stringValue = value;
    } else if (value is bool || value is int || value is double) {
      stringValue = value.toString();
    } else {
      // لو object أو Map
      stringValue = jsonEncode(value);
    }

    await flutterSecureStorage.write(key: key, value: stringValue);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredValue(String key, {required Type type}) async {
    const flutterSecureStorage = FlutterSecureStorage();
    final value = await flutterSecureStorage.read(key: key);

    if (value == null) return null;

    if (type == String) return value;
    if (type == int) return int.tryParse(value);
    if (type == double) return double.tryParse(value);
    if (type == bool) return value == 'true';
    if (type == Map || type == List) return jsonDecode(value);

    return value; // fallback
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }

  /// Removes a [key] from the FlutterSecureStorage
  static clearSecuredData(String key) async {
    debugPrint('FlutterSecureStorage : data has been cleared with key : $key');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: key);
  }
}
