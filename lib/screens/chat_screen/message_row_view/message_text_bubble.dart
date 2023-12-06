import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class MessageTextContainer extends StatelessWidget {
  final String message;

  const MessageTextContainer({super.key, required this.message});

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
      constraints: BoxConstraints(
        minWidth: 40,
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      decoration: BoxDecoration(
        color: context.theme.messageColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: context.theme.textPrimaryColor,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
