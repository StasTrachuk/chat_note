import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class DrawerItem extends StatelessWidget {
  final String asset;
  final String itemName;
  final VoidCallback onTap;

  const DrawerItem({
    this.asset = 'assets/drawer_icons/folder.png',
    required this.onTap,
    required this.itemName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              asset,
              height: 24,
              width: 25,
              color: context.theme.drawerItemIconColor,
            ),
            const SizedBox(width: 8),
            Text(
              itemName,
              style: TextStyle(
                color: context.theme.textSecondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
