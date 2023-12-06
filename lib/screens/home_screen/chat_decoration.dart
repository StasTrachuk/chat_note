import 'package:flutter/material.dart';
import 'package:home_work/settings/context_theme.dart';

class ChatDecoration extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ChatDecoration({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.onLongPress,
  });

  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: context.theme.chatItemColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.asset(
              icon,
              height: 24,
              width: 24,
              color: context.theme.iconSecondaryColor,
            ),
            const SizedBox(width: 18),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: context.theme.textSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
