import 'package:flutter/material.dart';

class AppColors {
  static const darkBlue = Color(0xFF3C4A94);
  static const blue = Color(0xFF5A74D2);
  static const lightBlue = Color(0xFFDAE2FF);
  static const sky = Color(0xFFf6f9ff);
  static const white = Color(0xFFFFFFFF);
  static const greyBlue = Color(0xFF797A93);
  static const greyLight = Color.fromARGB(255, 222, 222, 222);
  static const grey = Color(0xFF7c7e7e);
  static const greyDark = Color(0xFF494a4a);
  static const black = Color(0xFF000000);
  static const blackLight = Color(0xFF3d3d3d);
  static const blackDark = Color(0xFF0a0a0a);
}

class AppTheme {
  bool isDark;
  ThemeData themeData;
  final Color white;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color textNotActiveColor;
  final Color textActiveColor;
  final Color textFieldPrimaryColor;
  final Color textFieldSecondaryColor;
  final Color iconPrimaryColor;
  final Color iconSecondaryColor;
  final Color buttonPrimaryColor;
  final Color buttonSecondaryColor;
  final Color buttonNotActiveColor;
  final Color selectIconButtonColor;
  final Color borderPrimaryColor;
  final Color borderSecondaryColor;
  final Color borderNotActiveColor;
  final Color backgroundPrimaryColor;
  final Color backgroundSecondaryColor;
  final Color chatSecondBarColor;
  final Color messageColor;
  final Color spinKitColor;
  final Color chatItemColor;
  final Color switchColor;
  final Color switchNotActiveColor;
  final Color switchToggleColor;
  final Color checkBoxBorderColor;
  final Color drawerItemIconColor;
  final Color messageCategoryColor;
  final Color shadowColor;
  final Color dividerColor;
  final Color textFieldActiveBorderColor;
  final Color textFieldNotActiveBorderColor;

  AppTheme({
    required this.borderNotActiveColor,
    required this.chatSecondBarColor,
    required this.textActiveColor,
    required this.isDark,
    required this.white,
    required this.themeData,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.buttonPrimaryColor,
    required this.selectIconButtonColor,
    required this.iconPrimaryColor,
    required this.iconSecondaryColor,
    required this.borderPrimaryColor,
    required this.borderSecondaryColor,
    required this.buttonSecondaryColor,
    required this.textFieldPrimaryColor,
    required this.backgroundPrimaryColor,
    required this.backgroundSecondaryColor,
    required this.messageColor,
    required this.spinKitColor,
    required this.chatItemColor,
    required this.switchColor,
    required this.switchToggleColor,
    required this.textNotActiveColor,
    required this.buttonNotActiveColor,
    required this.checkBoxBorderColor,
    required this.drawerItemIconColor,
    required this.messageCategoryColor,
    required this.textFieldSecondaryColor,
    required this.shadowColor,
    required this.switchNotActiveColor,
    required this.dividerColor,
    required this.textFieldActiveBorderColor,
    required this.textFieldNotActiveBorderColor,
  });
}
