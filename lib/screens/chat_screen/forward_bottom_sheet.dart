import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/forward_sheet_bloc/forward_sheet_bloc.dart';

import 'package:home_work/screens/home_screen/chat_decoration.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/arrow_back_button.dart';
import 'package:home_work/widgets/chek_box.dart';
import 'package:home_work/widgets/loader.dart';
import 'package:home_work/widgets/secondary_button.dart';

class ForwardScreen extends StatefulWidget {
  final List<int> messageIds;
  final int chatId;
  final VoidCallback backToNoneMode;
  final ScrollController controller;
  final BuildContext context;

  const ForwardScreen({
    super.key,
    required this.context,
    required this.messageIds,
    required this.chatId,
    required this.controller,
    required this.backToNoneMode,
  });

  @override
  State<ForwardScreen> createState() => _ForwardScreenState();
}

class _ForwardScreenState extends State<ForwardScreen> {
  int? selectedChatId;

  @override
  build(BuildContext context) {
    return BlocProvider<ForwardSheetCubit>(
      create: (context) => GetIt.instance.get(param1: widget.chatId),
      child: Container(
        color: context.theme.backgroundPrimaryColor,
        child: BlocBuilder<ForwardSheetCubit, ForwardState>(
          builder: (context, state) {
            return switch (state) {
              ForwardStateInitial() => const SizedBox(),
              ForwardStateLoading() => const Loader(),
              ForwardStateLoaded(:final chats) => Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ArrowBackButton(
                            color: context.theme.iconSecondaryColor,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Forward ${widget.messageIds.length} messeges',
                            style: TextStyle(
                              color: context.theme.textSecondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          SecondaryButton(
                            isActive: selectedChatId != null,
                            text: 'Send',
                            onPressed: () async {
                              if (selectedChatId != null) {
                                context
                                    .read<ForwardSheetCubit>()
                                    .forwardMessage(
                                      messageIds: widget.messageIds,
                                      toChatId: selectedChatId!,
                                    );
                                widget.backToNoneMode();
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          controller: widget.controller,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (chats[index].id! != widget.chatId) {
                                  selectedChatId = state.chats[index].id!;
                                  setState(() {});
                                }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ChatDecoration(
                                      icon: chats[index].icon,
                                      title: chats[index].title,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CheckBox(
                                    isSelect:
                                        selectedChatId == chats[index].id!,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ForwardStateError(:final error) => Center(
                  child: Text(error),
                )
            };
          },
        ),
      ),
    );
  }
}
