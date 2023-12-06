import 'package:flutter/material.dart';
import 'package:home_work/settings/colors.dart';

final AppTheme lightTheme = AppTheme(
  // Фоновые цвета
  backgroundPrimaryColor: AppColors.sky,
  backgroundSecondaryColor: AppColors.white,

  // Цвета кнопок
  selectIconButtonColor: AppColors.lightBlue,
  buttonPrimaryColor: AppColors.blue,
  buttonSecondaryColor: const Color.fromARGB(0, 255, 255, 255),
  buttonNotActiveColor: AppColors.lightBlue,

  // Цвета границ
  borderPrimaryColor: AppColors.blue,
  borderSecondaryColor: AppColors.white,
  borderNotActiveColor: AppColors.greyLight,
  checkBoxBorderColor: AppColors.blue,

  // Цвета иконок
  drawerItemIconColor: AppColors.black,
  iconPrimaryColor: AppColors.white,
  iconSecondaryColor: AppColors.blue,
  messageCategoryColor: AppColors.sky,

  // Цвет текста
  textActiveColor: AppColors.darkBlue,
  textPrimaryColor: AppColors.white,
  textSecondaryColor: AppColors.black,
  textNotActiveColor: AppColors.greyBlue,

  //текстовое поле
  textFieldPrimaryColor: AppColors.lightBlue,
  textFieldSecondaryColor: AppColors.white,
  textFieldActiveBorderColor: AppColors.blue,
  textFieldNotActiveBorderColor: AppColors.white,

  // Остальные цвета
  chatSecondBarColor: AppColors.sky,
  chatItemColor: AppColors.lightBlue,
  switchColor: AppColors.darkBlue,
  switchNotActiveColor: AppColors.grey,
  switchToggleColor: AppColors.white,
  spinKitColor: AppColors.black,
  shadowColor: AppColors.greyBlue,
  dividerColor: AppColors.blue,

  messageColor: AppColors.blue,
  isDark: false,
  white: AppColors.white,

  themeData: ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.blue,
      toolbarHeight: 44,
      elevation: 0,
    ),
  ),
);

final AppTheme darkTheme = AppTheme(
  // Фоновые цвета
  backgroundPrimaryColor: AppColors.blackLight,
  backgroundSecondaryColor: AppColors.greyDark,

  // Цвета кнопок
  selectIconButtonColor: const Color(0xFFC6C6C6),
  buttonPrimaryColor: AppColors.blackDark,
  buttonSecondaryColor: const Color.fromARGB(0, 61, 61, 61),
  buttonNotActiveColor: AppColors.grey,

  // Цвета границ
  borderPrimaryColor: AppColors.greyLight,
  borderSecondaryColor: AppColors.blackLight,
  borderNotActiveColor: AppColors.greyDark,
  checkBoxBorderColor: AppColors.black,

  // Цвета иконок
  drawerItemIconColor: AppColors.white,
  iconPrimaryColor: AppColors.white,
  iconSecondaryColor: AppColors.white,
  messageCategoryColor: AppColors.greyDark,

  // Цвет текста
  textActiveColor: AppColors.white,
  textPrimaryColor: AppColors.white,
  textSecondaryColor: AppColors.greyLight,
  textNotActiveColor: AppColors.grey,

  //текстовое поле
  textFieldPrimaryColor: AppColors.greyDark,
  textFieldSecondaryColor: AppColors.blackLight,
  textFieldActiveBorderColor: AppColors.greyLight,
  textFieldNotActiveBorderColor: AppColors.blackLight,

  // Остальные цвета
  chatSecondBarColor: AppColors.greyDark,
  chatItemColor: AppColors.black,
  switchColor: AppColors.greyDark,
  switchNotActiveColor: AppColors.greyLight,
  switchToggleColor: AppColors.black,
  spinKitColor: AppColors.white,
  shadowColor: AppColors.black,
  dividerColor: AppColors.greyLight,

  messageColor: AppColors.blackDark,

  isDark: true,
  white: AppColors.white,

  themeData: ThemeData(
    appBarTheme: const AppBarTheme(
      toolbarHeight: 44,
      elevation: 0,
      color: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.blackLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.grey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
    ),
  ),
);
