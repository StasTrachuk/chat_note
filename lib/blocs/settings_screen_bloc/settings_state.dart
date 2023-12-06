part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final bool messageSetting;
  final bool dateSetting;
  final bool authSetting;

  SettingsLoaded({
    required this.authSetting,
    required this.dateSetting,
    required this.messageSetting,
  });
}

final class SettingsError extends SettingsState {
  final String error;

  SettingsError({required this.error});
}
