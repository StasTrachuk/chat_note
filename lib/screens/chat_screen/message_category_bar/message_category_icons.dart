class MessageCategoryIcons {
  static final List<String> icons = [
    'assets/icons/3.png',
    'assets/icons/4.png',
    'assets/icons/5.png',
    'assets/icons/6.png',
    'assets/icons/7.png',
    'assets/icons/8.png',
    'assets/icons/1.png',
    'assets/icons/2.png',
  ];

  static int selectedIndex = 0;

  static String selectedIcon() => icons[selectedIndex];
}
