part of 'forward_sheet_bloc.dart';

@immutable
sealed class ForwardState {}

final class ForwardStateInitial extends ForwardState {}

final class ForwardStateLoading extends ForwardState {}

final class ForwardStateLoaded extends ForwardState {
  final List<Chat> chats;
  ForwardStateLoaded({required this.chats});
}

final class ForwardStateError extends ForwardState {
  final String error;
  ForwardStateError(this.error);
}
