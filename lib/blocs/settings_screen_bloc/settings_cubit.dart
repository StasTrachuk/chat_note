import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home_work/core/shared_pref.dart';

part 'settings_state.dart';

class SettingsScreenCubit extends Cubit<SettingsState> {
  final SharedPref pref;
  late bool _messageSetting;
  late bool _dateSetting;
  late bool _authSetting;

  SettingsScreenCubit({required this.pref}) : super(SettingsInitial()) {
    _init();
  }

  void _init() async {
    emit(SettingsLoading());
    try {
      _messageSetting = await pref.getMessageSettings();
      _dateSetting = await pref.getDateSettings();
      _authSetting = await pref.getAuthSetting();

      emit(
        SettingsLoaded(
          messageSetting: _messageSetting,
          dateSetting: _dateSetting,
          authSetting: _authSetting,
        ),
      );
    } catch (e) {
      emit(
        SettingsError(error: e.toString()),
      );
    }
  }

  void setMessageSetting(bool value) async {
    try {
      await pref.setMessageSettings(value);
      _messageSetting = value;
      emit(
        SettingsLoaded(
          messageSetting: _messageSetting,
          dateSetting: _dateSetting,
          authSetting: _authSetting,
        ),
      );
    } catch (e) {
      emit(
        SettingsError(error: e.toString()),
      );
    }
  }

  void setDateSetting(bool value) async {
    try {
      await pref.setDateSettings(value);
      _dateSetting = value;
      emit(
        SettingsLoaded(
          messageSetting: _messageSetting,
          dateSetting: _dateSetting,
          authSetting: _authSetting,
        ),
      );
    } catch (e) {
      emit(
        SettingsError(error: e.toString()),
      );
    }
  }

  void setAuthSetting(bool value) async {
    try {
      await pref.setAuthSettings(value);
      _authSetting = value;
      emit(
        SettingsLoaded(
          messageSetting: _messageSetting,
          dateSetting: _dateSetting,
          authSetting: _authSetting,
        ),
      );
    } catch (e) {
      emit(
        SettingsError(error: e.toString()),
      );
    }
  }
}
