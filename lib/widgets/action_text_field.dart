import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class ActionTextField extends StatelessWidget {
  final String? hintText;
  final bool? autofocus;
  final bool oneLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const ActionTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.autofocus,
    this.controller,
    this.onEditingComplete,
    this.onSubmitted,
    this.hintText,
    this.oneLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: oneLine ? 1 : 3,
      focusNode: focusNode,
      style: TextStyle(
        fontSize: 16,
        color: context.theme.textSecondaryColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.theme.textFieldPrimaryColor,
        contentPadding: const EdgeInsets.fromLTRB(20, 3, 12, 3),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: context.theme.textFieldActiveBorderColor,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: context.theme.textFieldNotActiveBorderColor,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        iconColor: context.theme.iconPrimaryColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: context.theme.textNotActiveColor,
        ),
      ),
      controller: controller,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
    );
  }
}
