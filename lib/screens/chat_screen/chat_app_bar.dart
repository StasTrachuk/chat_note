import 'package:flutter/material.dart';
import 'package:home_work/screens/chat_screen/chat_screen.dart';
import 'package:home_work/screens/search_screen/seach_screen.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/arrow_back_button.dart';
import 'package:home_work/widgets/assets.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback backToSelectMode;
  final VoidCallback backToNoneMode;
  final Mode currentMode;
  final String title;
  final int chatId;

  const ChatAppBar({
    super.key,
    required this.backToNoneMode,
    required this.backToSelectMode,
    required this.title,
    required this.currentMode,
    required this.chatId,
  });

  @override
  Size get preferredSize => const Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    if (currentMode == Mode.select) {
      return AppBar(
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: backToNoneMode,
          icon: Image.asset(
            Assets.close,
            color: context.theme.iconPrimaryColor,
            height: 24,
            width: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: context.theme.textPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    } else if (currentMode == Mode.edit) {
      return AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Edit',
          style: TextStyle(
            color: context.theme.textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          onPressed: backToSelectMode,
          icon: Image.asset(
            Assets.close,
            color: context.theme.iconPrimaryColor,
            height: 24,
            width: 24,
          ),
        ),
      );
    } else {
      return AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
            color: context.theme.textPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: const ArrowBackButton(),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => SearchScreen(chatId: chatId),
              ),
            ),
            icon: Image.asset(
              Assets.search,
              color: context.theme.iconPrimaryColor,
              height: 20,
            ),
          ),
        ],
      );
    }
  }
}
