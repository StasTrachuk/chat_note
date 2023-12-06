import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/chat_screen_bloc/chat_screen_state.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/core/shared_pref.dart';
import 'package:home_work/models/message.dart';

class ChatScreenCubit extends Cubit<ChatState> {
  final int chatId;
  final MessageRepository repository;
  final SharedPref pref;
  late bool _isDateCentered;
  late bool _isMessageRightPosition;
  late StreamSubscription _subscription;
  late List<Message> _messages;

  ChatScreenCubit({
    required this.chatId,
    required this.repository,
    required this.pref,
  }) : super(ChatScreenInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void _init() async {
    _isDateCentered = await pref.getDateSettings();
    _isMessageRightPosition = await pref.getMessageSettings();
    _listenMessageStream();
    _getMessages();
  }

  void _listenMessageStream() {
    _subscription = repository.messageUpdatesStream.listen(
      (event) {
        _messages = event;
        emit(
          ChatScreenLoaded(
            messages: _messages,
            isDateCentered: _isDateCentered,
            isMessageRightPosition: _isMessageRightPosition,
          ),
        );
      },
    );
  }

  void _getMessages() async {
    emit(ChatScreenLoading());
    try {
      await repository.getMessages(chatId: chatId);
    } catch (e) {
      emit(ChatScreenError(error: e.toString()));
    }
  }

  void editMessage({required Message message}) async {
    emit(ChatScreenLoading());
    try {
      await repository.editMessage(message: message, chatId: chatId);
    } catch (e) {
      emit(ChatScreenError(error: e.toString()));
    }
  }

  void deleteMessage({required List<int> messageIds}) async {
    emit(ChatScreenLoading());
    try {
      await repository.deleteMessage(messageIds: messageIds, chatId: chatId);
    } catch (e) {
      emit(ChatScreenError(error: e.toString()));
    }
  }

  void addMessage({
    required String text,
    required String time,
    required int chatId,
    required String? messageCategory,
    required String date,
  }) async {
    Message message = Message(
      text: text,
      time: time,
      date: date,
      chatId: chatId,
      messageCategory: messageCategory,
    );

    try {
      repository.insertMessage(message: message);
    } catch (e) {
      emit(ChatScreenError(error: e.toString()));
    }
  }
}
