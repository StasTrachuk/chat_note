part of 'search_screen_cubit.dart';

sealed class SearchScreenState {}

class SearchScreenInitial extends SearchScreenState {}

class SearchScreenLoading extends SearchScreenState {}

class SearchScreenLoaded extends SearchScreenState {
  List<Message> messages;

  SearchScreenLoaded({required this.messages});
}

class SearchScreenError extends SearchScreenState {
  String error;
  SearchScreenError({required this.error});
}
