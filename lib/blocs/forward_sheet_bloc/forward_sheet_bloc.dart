import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:home_work/core/chat_repository.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/models/chat.dart';
part 'forward_sheet_state.dart';

class ForwardSheetCubit extends Cubit<ForwardState> {
  final int chatId;
  final MessageRepository messageRepository;
  final ChatRepository chatRepository;
  late StreamSubscription _subscription;
  late List<Chat> _chats;

  ForwardSheetCubit({
    required this.chatId,
    required this.messageRepository,
    required this.chatRepository,
  }) : super(ForwardStateInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void _init() {
    _listenMessageStream();
    _getChats();
  }

  _listenMessageStream() {
    _subscription = chatRepository.chatUpdatesStream.listen(
      (event) {
        _chats = List.from(event);
        _chats.removeWhere((element) => element.id == chatId);
        emit(ForwardStateLoaded(chats: _chats));
      },
    );
  }

  void _getChats() async {
    emit(ForwardStateLoading());
    try {
      await chatRepository.getChats();
    } catch (e) {
      emit(ForwardStateError(e.toString()));
    }
  }

  Future<void> forwardMessage({
    required List<int> messageIds,
    required int toChatId,
  }) async {
    emit(ForwardStateLoading());
    try {
      await messageRepository.forwardMessage(
        messageIds: messageIds,
        fromChatId: chatId,
        toChatId: toChatId,
      );
    } catch (e) {
      emit(ForwardStateError(e.toString()));
    }
  }
}
