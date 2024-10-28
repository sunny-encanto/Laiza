part of 'message_media_bloc.dart';

sealed class MessageMediaState extends Equatable {
  const MessageMediaState();

  @override
  List<Object> get props => [];
}

final class MessageMediaInitial extends MessageMediaState {}

final class MessageMediaLoading extends MessageMediaState {}

final class MessageMediaDownloaded extends MessageMediaState {
  final List<String> downloadedItemsList;
  const MessageMediaDownloaded(this.downloadedItemsList);
  @override
  List<Object> get props => [downloadedItemsList];
}
