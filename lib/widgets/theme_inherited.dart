import 'package:flutter/material.dart';
import 'package:home_work/settings/colors.dart';

class ThemeInherited extends InheritedWidget {
  final AppTheme appTheme;

  const ThemeInherited({
    super.key,
    required this.appTheme,
    required super.child,
  });

  static ThemeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInherited>()!;
  }

  @override
  bool updateShouldNotify(ThemeInherited oldWidget) {
    return this != oldWidget;
  }
}
