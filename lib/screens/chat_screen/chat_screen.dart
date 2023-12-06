import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:home_work/screens/chat_screen/message_row_view/date_bubble.dart';
import 'package:home_work/screens/chat_screen/message_row_view/message_row_view.dart';
import 'package:home_work/widgets/animated_icon_button.dart';
import 'package:home_work/widgets/assets.dart';
import 'package:home_work/widgets/formatter.dart';
import 'package:home_work/screens/chat_screen/image_picker_sheet/image_picker_sheet.dart';
import 'package:home_work/blocs/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:home_work/blocs/chat_screen_bloc/chat_screen_state.dart';
import 'package:home_work/models/message.dart';
import 'package:home_work/screens/chat_screen/chat_app_bar.dart';
import 'package:home_work/screens/chat_screen/second_bar.dart';
import 'package:home_work/screens/chat_screen/message_category_bar/message_category_bar.dart';
import 'package:home_work/screens/chat_screen/message_category_bar/message_category_icons.dart';
import 'package:home_work/screens/chat_screen/forward_bottom_sheet.dart';
import 'package:home_work/settings/context_theme.dart';
import 'package:home_work/widgets/action_text_field.dart';
import 'package:home_work/widgets/loader.dart';

enum Mode {
  none,
  select,
  edit,
}

class ChatScreen extends StatefulWidget {
  final int chatId;
  final String title;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.title,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _selectedMessages = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _showMessageCategoryBar = false;
  Mode _currentMode = Mode.none;

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<ChatScreenCubit>(param1: widget.chatId),
      child: BlocBuilder<ChatScreenCubit, ChatState>(
        builder: (context, state) => Scaffold(
          appBar: ChatAppBar(
            backToNoneMode: _backToNoneMode,
            backToSelectMode: _backToSelectMode,
            currentMode: _currentMode,
            chatId: widget.chatId,
            title: widget.title,
          ),
          body: SafeArea(
            bottom: true,
            child: Column(
              children: [
                Expanded(
                  child: switch (state) {
                    ChatScreenInitial() => const SizedBox(),
                    ChatScreenLoading() => const Loader(),
                    ChatScreenLoaded(
                      :final messages,
                      :final isMessageRightPosition,
                      :final isDateCentered
                    ) =>
                      GestureDetector(
                        onTap: _unfocus,
                        child: Stack(
                          children: [
                            ListView.separated(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                bool showDate =
                                    _showDateBubble(messages, index);
                                Message message = messages[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (showDate)
                                      DateBubble(
                                        isCenter: isDateCentered,
                                        isRight: isMessageRightPosition,
                                        text: message.date,
                                      ),
                                    MessageRowView(
                                      isSelectMode: _currentMode == Mode.select,
                                      message: message,
                                      isMessageRightPosition:
                                          isMessageRightPosition,
                                      isCheckBoxSelect:
                                          _selectedMessages.contains(message),
                                      onCheckBoxTap: () =>
                                          _onMessageTap(message),
                                      onMessageLongPress: () =>
                                          _onMessageLongPress(message),
                                      onMessageTap: () =>
                                          _onMessageTap(message),
                                    ),
                                  ],
                                );
                              },
                            ),
                            if (_showMessageCategoryBar)
                              const MessageCategoryBar(),
                            SecondBar(
                              length: _selectedMessages.length,
                              forward: _openForwardSheet,
                              currentMode: _currentMode,
                              delete: () => _delete(context),
                              edit: _edit,
                              copy: _copy,
                              selectedIsNotEmpty: _selectedMessages.isNotEmpty,
                              isSingleTextMessageSelected:
                                  _singleTextMessageSelected(),
                            ),
                          ],
                        ),
                      ),
                    ChatScreenError(:final error) => Center(
                        child: Text(error),
                      ),
                  },
                ),
                Divider(
                  thickness: 0.1,
                  color: context.theme.dividerColor,
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: ActionTextField(
                        oneLine: false,
                        prefixIcon: IconButton(
                          onPressed: () => setState(() {
                            _showMessageCategoryBar = !_showMessageCategoryBar;
                          }),
                          icon: Image.asset(
                            Assets.lightBulb,
                            color: _showMessageCategoryBar
                                ? context.theme.iconSecondaryColor
                                : context.theme.iconPrimaryColor,
                            height: 25,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: _openImagePicker,
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: context.theme.iconSecondaryColor,
                          ),
                        ),
                        hintText: "What's new?",
                        focusNode: _focusNode,
                        controller: _textController,
                        onEditingComplete: () {},
                        onSubmitted: (value) => _sendMessage(
                          context,
                          value,
                        ),
                      ),
                    ),
                    AnimatedIconButton(
                      onTap: () => _sendMessage(
                        context,
                        _textController.text,
                      ),
                      asset: Assets.send,
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _singleTextMessageSelected() {
    return _selectedMessages.isNotEmpty &&
        _selectedMessages.first.text != null &&
        _selectedMessages.length == 1;
  }

  void _openForwardSheet() async {
    if (_selectedMessages.isNotEmpty) {
      await showFlexibleBottomSheet(
        maxHeight: 0.8,
        initHeight: 0.5,
        context: context,
        useRootScaffold: true,
        builder: (
          BuildContext context,
          ScrollController controller,
          double bottomSheetOffset,
        ) {
          return ForwardScreen(
            context: context,
            controller: controller,
            chatId: widget.chatId,
            backToNoneMode: _backToNoneMode,
            messageIds: _selectedMessages.map((e) => e.id!).toList(),
          );
        },
      );
    }
  }

  Future<void> _openImagePicker() async {
    await showFlexibleBottomSheet(
      maxHeight: 0.5,
      initHeight: 0.5,
      context: context,
      useRootScaffold: true,
      bottomSheetColor: context.theme.backgroundPrimaryColor,
      builder: (
        BuildContext context,
        ScrollController controller,
        double bottomSheetOffset,
      ) {
        return ImagePickerSheet(
          controller: controller,
          chatId: widget.chatId,
        );
      },
    );
  }

  void _unfocus() {
    _focusNode.hasFocus ? _focusNode.unfocus() : null;
    if (_showMessageCategoryBar) {
      setState(
        () => _showMessageCategoryBar = false,
      );
    }
  }

  void _backToNoneMode() {
    _focusNode.unfocus();

    setState(
      () {
        _currentMode = Mode.none;
        _selectedMessages.clear();
      },
    );
  }

  void _delete(BuildContext context) {
    context.read<ChatScreenCubit>().deleteMessage(
          messageIds: _selectedMessages.map((e) => e.id!).toList(),
        );
    _currentMode = Mode.none;
    _selectedMessages.clear();
  }

  void _backToSelectMode() {
    _textController.clear();
    setState(() => _currentMode = Mode.select);
  }

  void _edit() {
    setState(
      () {
        _textController.text = _selectedMessages.first.text!;
        _currentMode = Mode.edit;
      },
    );
    _focusNode.requestFocus();
    _textController.selection.end;
  }

  void _copy() {
    Clipboard.setData(
      ClipboardData(text: _selectedMessages.first.text!),
    );

    setState(
      () {
        _selectedMessages.clear();
        _currentMode = Mode.none;
      },
    );
  }

  void _onMessageTap(Message message) {
    if (_currentMode == Mode.select) {
      setState(
        () {
          _selectedMessages.contains(message)
              ? _selectedMessages.remove(message)
              : _selectedMessages.add(message);
        },
      );
    }
  }

  void _onMessageLongPress(Message message) {
    if (_currentMode != Mode.edit) {
      setState(
        () {
          if (_currentMode == Mode.select) {
            _currentMode = Mode.none;
            _selectedMessages.clear();
          } else {
            _currentMode = Mode.select;
            _selectedMessages.add(message);
          }
        },
      );
    }
  }

  void _sendMessage(BuildContext context, String value) {
    if (_currentMode == Mode.edit && value.trim().isNotEmpty) {
      _editModeSending(context, value);
    } else if (_currentMode == Mode.none && value.trim().isNotEmpty) {
      _noneModeSending(context, value);
    }
  }

  bool _showDateBubble(List<Message> messages, int index) {
    //is single message
    if (messages.length == 1) return true;
    //is last message
    if (index == messages.length - 1) return true;
    // is Different dates
    if (messages[index].date != messages[index + 1].date) return true;
    return false;
  }

  void _noneModeSending(BuildContext context, String value) {
    context.read<ChatScreenCubit>().addMessage(
          text: value,
          date: Formatter.formatDate(DateTime.now()),
          time: Formatter.formatTime(DateTime.now()),
          chatId: widget.chatId,
          messageCategory: _showMessageCategoryBar
              ? MessageCategoryIcons.selectedIcon()
              : null,
        );

    _textController.clear();
    _showMessageCategoryBar = false;
  }

  void _editModeSending(
    BuildContext context,
    String value,
  ) {
    context.read<ChatScreenCubit>().editMessage(
          message: _selectedMessages.first.copyWith(text: value),
        );
    _textController.clear();
    _selectedMessages.clear();
    _currentMode = Mode.none;
    _showMessageCategoryBar = false;
  }
}
