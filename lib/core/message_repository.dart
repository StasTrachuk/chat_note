import 'package:home_work/models/message.dart';

abstract interface class MessageRepository {
  Stream<List<Message>> get messageUpdatesStream;

  Future<void> getMessages({required int chatId});

  Future<void> insertMessage({required Message message});

  Future<void> editMessage({
    required Message message,
    required int chatId,
  });

  Future<void> deleteMessage({
    required List<int> messageIds,
    required int chatId,
  });

  Future<List<Message>> searchMessages({
    required String searchingText,
    required int chatId,
  });

  Future<void> forwardMessage({
    required List<int> messageIds,
    required int fromChatId,
    required int toChatId,
  });
}
