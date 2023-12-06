import 'package:flutter/material.dart';
import 'package:home_work/screens/home_screen/drawer/drawer_item.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/assets.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 233,
      color: context.theme.backgroundPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  asset: Assets.addFolder,
                  itemName: 'Add folder',
                  onTap: () {},
                ),
                DrawerItem(
                  asset: Assets.delete,
                  itemName: 'Add folder',
                  onTap: () {},
                ),
                DrawerItem(
                  asset: Assets.settings,
                  itemName: 'Settings',
                  onTap: () => Navigator.pushNamed(context, '/settings_screen'),
                ),
                DrawerItem(
                  asset: Assets.appRate,
                  itemName: 'Add folder',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
