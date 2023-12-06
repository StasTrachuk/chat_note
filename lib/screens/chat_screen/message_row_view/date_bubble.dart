import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class DateBubble extends StatelessWidget {
  final bool isCenter;
  final bool isRight;
  final String text;

  const DateBubble({
    required this.text,
    required this.isCenter,
    required this.isRight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCenter
          ? Alignment.center
          : isRight
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            color: context.theme.textNotActiveColor,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
