import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:home_work/settings/context_theme.dart';

class SettingsItem extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool value) onToggle;

  const SettingsItem({
    required this.text,
    required this.value,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: context.theme.buttonNotActiveColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: context.theme.textSecondaryColor,
            ),
          ),
          FlutterSwitch(
            padding: 0,
            toggleSize: 18,
            height: 18,
            width: 28,
            inactiveColor: context.theme.switchNotActiveColor,
            activeColor: context.theme.switchColor,
            toggleColor: context.theme.switchToggleColor,
            value: value,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
