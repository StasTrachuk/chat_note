import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/models/message.dart';
part 'search_screen_state.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  final MessageRepository repository;

  SearchScreenCubit({required this.repository}) : super(SearchScreenInitial());

  void search({
    required String value,
    required int chatId,
  }) async {
    try {
      emit(SearchScreenLoading());
      final List<Message> result = await repository.searchMessages(
        searchingText: value,
        chatId: chatId,
      );
      emit(SearchScreenLoaded(messages: result));
    } catch (e) {
      emit(SearchScreenError(error: e.toString()));
    }
  }
}
