import 'dart:async';
import 'package:home_work/core/shared_pref.dart';
import 'package:home_work/settings/colors.dart';
import 'package:home_work/settings/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl implements SharedPref {
  @override
  Future<AppTheme> getTheme() async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    bool isDark = preferens.getBool('darkTheme') ?? false;
    return isDark ? darkTheme : lightTheme;
  }

  @override
  Future<bool> getMessageSettings() async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    bool isEnabled = preferens.getBool('isMessageRightPosition') ?? false;
    return isEnabled;
  }

  @override
  Future<bool> getDateSettings() async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    bool isEnabled = preferens.getBool('isDateCentered') ?? true;
    return isEnabled;
  }

  @override
  Future<void> setTheme(bool isDark) async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    preferens.setBool('darkTheme', isDark);
  }

  @override
  Future<void> setMessageSettings(bool isEnabled) async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    preferens.setBool('isMessageRightPosition', isEnabled);
  }

  @override
  Future<void> setDateSettings(bool isEnabled) async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    preferens.setBool('isDateCentered', isEnabled);
  }

  @override
  Future<void> setAuthSettings(bool isEnabled) async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    preferens.setBool('isAuthOn', isEnabled);
  }

  @override
  Future<bool> getAuthSetting() async {
    SharedPreferences preferens = await SharedPreferences.getInstance();
    bool isEnabled = preferens.getBool('isAuthOn') ?? false;
    return isEnabled;
  }
}
