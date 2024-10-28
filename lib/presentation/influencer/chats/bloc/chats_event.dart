part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsLoadEvent extends ChatsEvent {}

class ChatsSearchEvent extends ChatsEvent {
  final String query;
  const ChatsSearchEvent(this.query);
  @override
  List<Object> get props => [query];
}
