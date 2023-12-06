import 'package:home_work/settings/colors.dart';

abstract interface class SharedPref {
  Future<void> setTheme(bool isDark);

  Future<AppTheme> getTheme();

  Future<void> setMessageSettings(bool isEnabled);

  Future<bool> getMessageSettings();

  Future<void> setDateSettings(bool isEnabled);

  Future<bool> getDateSettings();

  Future<void> setAuthSettings(bool isEnabled);

  Future<bool> getAuthSetting();
}
