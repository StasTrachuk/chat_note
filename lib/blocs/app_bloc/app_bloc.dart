import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/app_bloc/app_state.dart';
import 'package:home_work/core/shared_pref.dart';
import 'package:home_work/settings/colors.dart';
import 'package:home_work/settings/themes.dart';

class AppCubit extends Cubit<AppState> {
  final SharedPref _pref = GetIt.instance.get<SharedPref>();
  AppTheme? _theme;

  AppCubit() : super(AppStateInitial(theme: lightTheme)) {
    _initTheme();
  }

  void _initTheme() async {
    _theme = await _pref.getTheme();
    emit(AppStateLoaded(_theme!));
  }

  void setTheme() {
    _theme = _theme == lightTheme ? darkTheme : lightTheme;
    _pref.setTheme(_theme == darkTheme);
    emit(AppStateLoaded(_theme!));
  }
}
