import 'package:home_work/models/chat.dart';

sealed class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Chat> chats;

  HomeScreenLoaded({required this.chats});
}

class HomeScreenError extends HomeScreenState {
  String error;
  HomeScreenError({required this.error});
}
