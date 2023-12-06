import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class SecondaryButton extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({
    required this.onPressed,
    required this.text,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        width: 107,
        decoration: BoxDecoration(
          color: isActive
              ? context.theme.buttonPrimaryColor
              : context.theme.buttonNotActiveColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive
                ? context.theme.textPrimaryColor
                : context.theme.textSecondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
