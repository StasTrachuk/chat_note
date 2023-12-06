import 'dart:async';

import 'package:home_work/core/chat_repository.dart';
import 'package:home_work/core/data_storage.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/data/data_storage_impl.dart';
import 'package:home_work/models/chat.dart';
import 'package:home_work/models/message.dart';

class DataStorageRepositoryImpl implements MessageRepository, ChatRepository {
  final DataStorage _database;
  final _chatStreamController = StreamController<List<Chat>>.broadcast();
  final _messageStreamController = StreamController<List<Message>>.broadcast();

  DataStorageRepositoryImpl(this._database);

  List<Message> messageToList(List<Map<String, Object?>> maps) {
    return maps.reversed.map((map) => Message.fromJson(map)).toList();
  }

  List<Chat> chatToList(List<Map<String, Object?>> maps) {
    return maps.reversed.map((map) => Chat.fromJson(map)).toList();
  }

  @override
  Stream<List<Chat>> get chatUpdatesStream => _chatStreamController.stream;

  @override
  Stream<List<Message>> get messageUpdatesStream =>
      _messageStreamController.stream;

  @override
  Future<void> getChats() async {
    final chatsData = await _database.read(table: ChatFields.chatsTableName);

    _chatStreamController.add(chatToList(chatsData));
  }

  @override
  Future<void> getMessages({required int chatId}) async {
    final messageData = await _database.read(
      table: MessageFields.messagesTableName,
      column: MessageFields.chatId,
      args: [chatId],
    );

    _messageStreamController.add(messageToList(messageData));
  }

  @override
  Future<void> insertChat({required Chat chat}) async {
    var updatedData = await _database.insert(
      table: ChatFields.chatsTableName,
      value: chat.toJson(),
    );

    _chatStreamController.add(
      chatToList(updatedData),
    );
  }

  @override
  Future<void> insertMessage({required Message message}) async {
    var updatedData = await _database.insert(
      table: MessageFields.messagesTableName,
      value: message.toJson(),
      column: MessageFields.chatId,
      args: [message.chatId],
    );

    _messageStreamController.add(
      messageToList(updatedData),
    );
  }

  @override
  Future<void> editChat({required Chat chat}) async {
    await _database.update(
      table: ChatFields.chatsTableName,
      value: chat.toJson(),
      column: ChatFields.id,
      args: [chat.id],
    );

    var updatedData = await _database.read(
      table: ChatFields.chatsTableName,
    );

    _chatStreamController.add(
      chatToList(updatedData),
    );
  }

  @override
  Future<void> editMessage({
    required Message message,
    required int chatId,
  }) async {
    await _database.update(
      table: MessageFields.messagesTableName,
      value: message.toJson(),
      column: MessageFields.id,
      args: [message.id],
    );

    var updatedData = await _database.read(
      table: MessageFields.messagesTableName,
      column: MessageFields.chatId,
      args: [chatId],
    );

    _messageStreamController.add(
      messageToList(updatedData),
    );
  }

  @override
  Future<void> deleteChat({required int chatId}) async {
    await _database.delete(
      table: ChatFields.chatsTableName,
      column: ChatFields.id,
      args: [chatId],
    );

    var updatedData = await _database.read(
      table: ChatFields.chatsTableName,
    );

    _chatStreamController.add(
      chatToList(updatedData),
    );
  }

  @override
  Future<void> deleteMessage({
    required List<int> messageIds,
    required int chatId,
  }) async {
    for (int id in messageIds) {
      _database.delete(
        table: MessageFields.messagesTableName,
        column: MessageFields.id,
        args: [id],
      );
    }

    var updatedData = await _database.read(
      table: MessageFields.messagesTableName,
      column: MessageFields.chatId,
      args: [chatId],
    );

    _messageStreamController.add(
      messageToList(updatedData),
    );
  }

  @override
  Future<void> forwardMessage({
    required List<int> messageIds,
    required int fromChatId,
    required int toChatId,
  }) async {
    for (int id in messageIds) {
      await _database.update(
        table: MessageFields.messagesTableName,
        value: {MessageFields.chatId: toChatId},
        column: MessageFields.id,
        args: [id],
      );
    }

    var updatedData = await _database.read(
      table: MessageFields.messagesTableName,
      column: MessageFields.chatId,
      args: [fromChatId],
    );

    _messageStreamController.add(
      messageToList(updatedData),
    );
  }

  @override
  Future<List<Message>> searchMessages({
    required String searchingText,
    required int chatId,
  }) async {
    var searchResult = await _database.searchMessage(
      args: [
        chatId,
        '%$searchingText%',
      ],
    );

    return messageToList(searchResult);
  }
}
