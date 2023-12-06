import 'package:home_work/settings/colors.dart';

abstract class AppState {
  abstract final AppTheme theme;
}

class AppStateInitial extends AppState {
  @override
  final AppTheme theme;

  AppStateInitial({required this.theme});
}

class AppStateLoading extends AppState {
  @override
  final AppTheme theme;

  AppStateLoading(this.theme);
}

class AppStateLoaded extends AppState {
  @override
  final AppTheme theme;

  AppStateLoaded(this.theme);
}

class AppStateError extends AppState {
  @override
  final AppTheme theme;

  final String error;

  AppStateError(this.theme, {required this.error});
}
