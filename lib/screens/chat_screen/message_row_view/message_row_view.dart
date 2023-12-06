import 'package:flutter/material.dart';
import 'package:home_work/models/message.dart';
import 'package:home_work/screens/chat_screen/message_row_view/message_view.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/chek_box.dart';

class MessageRowView extends StatelessWidget {
  final bool isCheckBoxSelect;
  final bool isSelectMode;
  final bool isMessageRightPosition;
  final Message message;
  final VoidCallback onCheckBoxTap;
  final VoidCallback onMessageTap;
  final VoidCallback onMessageLongPress;

  const MessageRowView({
    super.key,
    required this.isMessageRightPosition,
    required this.isCheckBoxSelect,
    required this.message,
    required this.onCheckBoxTap,
    required this.onMessageTap,
    required this.onMessageLongPress,
    required this.isSelectMode,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          isMessageRightPosition ? TextDirection.rtl : TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        verticalDirection: VerticalDirection.up,
        children: [
          GestureDetector(
            onTap: onMessageTap,
            onLongPress: onMessageLongPress,
            child: MessageView(message: message),
          ),
          isSelectMode
              ? CheckBox(
                  onTap: onCheckBoxTap,
                  isSelect: isCheckBoxSelect,
                )
              : Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.theme.textNotActiveColor,
                  ),
                ),
        ],
      ),
    );
  }
}
