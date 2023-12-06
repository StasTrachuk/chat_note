import 'package:home_work/models/message.dart';

sealed class ChatState {}

class ChatScreenInitial extends ChatState {}

class ChatScreenLoading extends ChatState {}

class ChatScreenLoaded extends ChatState {
  final bool isMessageRightPosition;
  final bool isDateCentered;
  final List<Message> messages;

  ChatScreenLoaded({
    required this.isMessageRightPosition,
    required this.isDateCentered,
    required this.messages,
  });
}

class ChatScreenError extends ChatState {
  final String error;
  ChatScreenError({required this.error});
}
