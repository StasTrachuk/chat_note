import 'package:flutter/material.dart';
import 'package:home_work/screens/chat_screen/message_category_bar/message_category_icons.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/chek_box.dart';

class MessageCategoryBar extends StatefulWidget {
  const MessageCategoryBar({super.key});

  @override
  State<MessageCategoryBar> createState() => _MessageCategoryBarState();
}

class _MessageCategoryBarState extends State<MessageCategoryBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.theme.messageCategoryColor,
          ),
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(0),
            crossAxisCount: 1,
            children: List.generate(
              MessageCategoryIcons.icons.length,
              (index) => GestureDetector(
                onTap: () => setState(() {
                  MessageCategoryIcons.selectedIndex = index;
                }),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.theme.buttonNotActiveColor,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                          MessageCategoryIcons.icons[index],
                          color: context.theme.iconSecondaryColor,
                          height: 40,
                          width: 40,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CheckBox(
                            border: false,
                            isSelect:
                                MessageCategoryIcons.selectedIndex == index,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
