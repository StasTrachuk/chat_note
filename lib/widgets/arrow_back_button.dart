import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/assets.dart';

class ArrowBackButton extends StatelessWidget {
  final Color? color;
  const ArrowBackButton({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Image.asset(
          Assets.arrowback,
          color: color ?? context.theme.white,
          height: 20,
        ),
      ),
    );
  }
}
