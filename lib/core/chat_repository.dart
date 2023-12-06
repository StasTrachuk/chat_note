import 'package:home_work/models/chat.dart';

abstract interface class ChatRepository {
  Stream<List<Chat>> get chatUpdatesStream;

  Future<void> getChats();

  Future<void> insertChat({required Chat chat});

  Future<void> editChat({required Chat chat});

  Future<void> deleteChat({required int chatId});
}
