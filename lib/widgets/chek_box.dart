import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/assets.dart';

class CheckBox extends StatefulWidget {
  final bool isSelect;
  final bool border;
  final VoidCallback? onTap;

  const CheckBox({
    super.key,
    this.onTap,
    this.isSelect = false,
    this.border = true,
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 20,
        height: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.isSelect
                ? context.theme.buttonPrimaryColor
                : context.theme.buttonSecondaryColor,
            shape: BoxShape.circle,
            border: widget.border
                ? Border.all(
                    color: widget.isSelect
                        ? context.theme.checkBoxBorderColor
                        : context.theme.borderNotActiveColor,
                  )
                : null,
          ),
          child: AnimatedOpacity(
            opacity: widget.isSelect ? 1.0 : 0,
            duration: const Duration(milliseconds: 100),
            child: Image.asset(
              Assets.check,
              height: 20,
              color: context.theme.iconPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
