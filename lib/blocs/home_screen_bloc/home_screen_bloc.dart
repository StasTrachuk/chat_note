import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_state.dart';
import 'package:home_work/core/chat_repository.dart';
import 'package:home_work/models/chat.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final ChatRepository repository;
  late List<Chat> _chats;
  late StreamSubscription _subscription;

  HomeScreenCubit({required this.repository}) : super(HomeScreenInitial()) {
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

  void _listenMessageStream() {
    _subscription = repository.chatUpdatesStream.listen(
      (event) {
        emit(HomeScreenLoading());
        _chats = event;
        emit(HomeScreenLoaded(chats: _chats));
      },
    );
  }

  Future<void> _getChats() async {
    emit(HomeScreenLoading());
    try {
      await repository.getChats();
    } catch (e) {
      emit(HomeScreenError(error: e.toString()));
    }
  }

  Future<void> deleteChat({required int chatId}) async {
    emit(HomeScreenLoading());
    try {
      await repository.deleteChat(chatId: chatId);
    } catch (e) {
      emit(HomeScreenError(error: e.toString()));
    }
  }

  Future<void> editChat(Chat chat) async {
    emit(HomeScreenLoading());
    try {
      await repository.editChat(chat: chat);
    } catch (e) {
      emit(HomeScreenError(error: e.toString()));
    }
  }

  Future<void> addChat({required icon, required title}) async {
    Chat chat = Chat(icon: icon, title: title);
    try {
      await repository.insertChat(chat: chat);
    } catch (e) {
      emit(HomeScreenError(error: e.toString()));
    }
  }
}
