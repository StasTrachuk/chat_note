import 'package:flutter/material.dart';

import 'package:home_work/settings/colors.dart';
import 'package:home_work/widgets/theme_inherited.dart';

extension ContextExtetsion on BuildContext {
  AppTheme get theme => ThemeInherited.of(this).appTheme;
}
