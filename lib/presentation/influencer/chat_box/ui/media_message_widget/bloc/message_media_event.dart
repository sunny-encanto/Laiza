part of 'message_media_bloc.dart';

sealed class MessageMediaEvent extends Equatable {
  const MessageMediaEvent();

  @override
  List<Object> get props => [];
}

class MedialMessageDownloadOrOpenEvent extends MessageMediaEvent {
  final Message message;
  const MedialMessageDownloadOrOpenEvent(this.message);
  @override
  List<Object> get props => [message];
}
