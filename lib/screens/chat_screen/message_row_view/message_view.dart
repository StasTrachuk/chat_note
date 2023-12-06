import 'package:flutter/material.dart';

import 'package:home_work/models/message.dart';
import 'package:home_work/screens/chat_screen/message_row_view/message_text_bubble.dart';
import 'package:home_work/settings/context_theme.dart';

class MessageView extends StatelessWidget {
  final Message message;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MessageView({
    super.key,
    required this.message,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Builder(
        builder: (context) {
          if (message.image != null) {
            return Container(
              height: 300,
              width: MediaQuery.sizeOf(context).width * 0.8,
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: context.theme.buttonNotActiveColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  message.image!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Container(
              decoration: message.messageCategory != null
                  ? BoxDecoration(
                      border: Border.all(
                        color: context.theme.borderNotActiveColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    )
                  : null,
              child: Row(
                children: [
                  MessageTextContainer(message: message.text!),
                  if (message.messageCategory != null)
                    Center(
                      child: Image.asset(
                        message.messageCategory!,
                        height: 30,
                        color: context.theme.iconSecondaryColor,
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
