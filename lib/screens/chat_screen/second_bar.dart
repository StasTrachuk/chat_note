import 'package:flutter/material.dart';
import 'package:home_work/screens/chat_screen/chat_screen.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/animated_icon_button.dart';
import 'package:home_work/widgets/assets.dart';

class SecondBar extends StatefulWidget {
  final int length;
  final Mode currentMode;
  final bool selectedIsNotEmpty;
  final bool isSingleTextMessageSelected;
  final VoidCallback edit;
  final VoidCallback copy;
  final VoidCallback delete;
  final VoidCallback forward;

  const SecondBar({
    super.key,
    required this.length,
    required this.forward,
    required this.currentMode,
    required this.edit,
    required this.copy,
    required this.delete,
    required this.selectedIsNotEmpty,
    required this.isSingleTextMessageSelected,
  });

  @override
  State<SecondBar> createState() => _SecondBarState();
}

class _SecondBarState extends State<SecondBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      top: widget.currentMode == Mode.select ? 0 : -45,
      child: SizedBox(
        height: 45,
        width: MediaQuery.sizeOf(context).width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.chatSecondBarColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Select: ${widget.length}',
                    style: TextStyle(color: context.theme.textActiveColor),
                  ),
                ),
                AnimatedIconButton(
                  onTap: widget.copy,
                  isAvaible: widget.isSingleTextMessageSelected,
                  asset: Assets.copy,
                ),
                AnimatedIconButton(
                  onTap: widget.edit,
                  isAvaible: widget.isSingleTextMessageSelected,
                  asset: Assets.edit,
                ),
                AnimatedIconButton(
                  onTap: widget.delete,
                  isAvaible: widget.selectedIsNotEmpty,
                  asset: Assets.delete,
                ),
                AnimatedIconButton(
                  onTap: widget.forward,
                  isAvaible: widget.length != 0,
                  asset: Assets.forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
