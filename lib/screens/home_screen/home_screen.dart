import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_state.dart';
import 'package:home_work/screens/home_screen/drawer/app_drawer.dart';
import 'package:home_work/screens/chat_screen/chat_screen.dart';
import 'package:home_work/screens/home_screen/home_bottom_sheet.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/loader.dart';
import 'chat_decoration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> selectedChatId = [];

  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leadingWidth: 39,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
              ),
            );
          },
        ),
        title: Text(
          'Notes',
          style: TextStyle(color: context.theme.textPrimaryColor),
        ),
      ),
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return switch (state) {
            HomeScreenInitial() => const SizedBox(),
            HomeScreenLoading() => const Loader(),
            HomeScreenLoaded(:final chats) => ListView.separated(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return ChatDecoration(
                    onLongPress: () {
                      showFlexibleBottomSheet(
                        initHeight: 0.3,
                        context: context,
                        builder: (
                          BuildContext context,
                          ScrollController controller,
                          double bottomSheetOffset,
                        ) {
                          return HomeBottomSheet(
                            onEdit: () => Navigator.pushNamed(
                              context,
                              '/edit_chat_screen',
                              arguments: chats[index],
                            ),
                            onDelete: () {
                              context
                                  .read<HomeScreenCubit>()
                                  .deleteChat(chatId: chats[index].id!);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ChatScreen(
                          chatId: chats[index].id!,
                          title: chats[index].title,
                        ),
                      ),
                    ),
                    icon: chats[index].icon,
                    title: chats[index].title,
                  );
                },
              ),
            HomeScreenError(:final error) => Center(
                child: Text(error),
              )
          };
        },
      ),
      floatingActionButton: FloatingButton(
        onTap: () => Navigator.pushNamed(context, '/create_screen'),
        child: Icon(
          Icons.add,
          weight: 1,
          size: 30,
          color: context.theme.iconPrimaryColor,
        ),
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  const FloatingButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: context.theme.buttonPrimaryColor,
        child: child,
      ),
    );
  }
}
