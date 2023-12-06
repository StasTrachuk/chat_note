import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class PrimaryButton extends StatelessWidget {
  final bool withBorder;
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({
    required this.onPressed,
    required this.text,
    this.withBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(224, 44),
        elevation: withBorder ? 0 : 3,
        backgroundColor: withBorder
            ? context.theme.buttonSecondaryColor
            : context.theme.buttonPrimaryColor,
        shape: RoundedRectangleBorder(
          side: withBorder
              ? BorderSide(
                  width: 1,
                  color: context.theme.borderPrimaryColor,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: withBorder
              ? context.theme.textSecondaryColor
              : context.theme.textPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
