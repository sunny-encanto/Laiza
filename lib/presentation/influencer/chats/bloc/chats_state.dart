part of 'chats_bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}

final class ChatsLoadingState extends ChatsState {}

final class ChatsErrorState extends ChatsState {
  final String message;
  const ChatsErrorState(this.message);
  @override
  List<Object> get props => [message];
}

final class ChatsLoadedSate extends ChatsState {
  final List<ConnectionsModel> chatsList;
  const ChatsLoadedSate(this.chatsList);
  @override
  List<Object> get props => [chatsList];
}
