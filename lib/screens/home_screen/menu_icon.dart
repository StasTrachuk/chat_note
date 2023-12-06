import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  final Function() onTap;
  const MenuIcon({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/app_icons/menu_icon_element.png'),
            const SizedBox(height: 6),
            Image.asset('assets/app_icons/menu_icon_element.png'),
            const SizedBox(height: 6),
            Image.asset('assets/app_icons/menu_icon_element.png'),
          ],
        ),
      ),
    );
  }
}
