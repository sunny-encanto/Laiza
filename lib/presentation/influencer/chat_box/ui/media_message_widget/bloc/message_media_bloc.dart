import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

part 'message_media_event.dart';
part 'message_media_state.dart';

class MessageMediaBloc extends Bloc<MessageMediaEvent, MessageMediaState> {
  List<String> downloadedDocIds = <String>[];
  MessageMediaBloc() : super(MessageMediaInitial()) {
    downloadedDocIds.addAll(PrefUtils.getDownloadedDocId());
    on<MedialMessageDownloadOrOpenEvent>(_onDownLoadOrOpen);
  }

  FutureOr<void> _onDownLoadOrOpen(MedialMessageDownloadOrOpenEvent event,
      Emitter<MessageMediaState> emit) async {
    String? filePath = await _isFileDownloaded(event.message.fileName ?? '');
    if (filePath != null) {
      if (!downloadedDocIds.contains(event.message.dcoId ?? "")) {
        downloadedDocIds.add(event.message.dcoId ?? "");
        PrefUtils.setDownloadedDocId(downloadedDocIds);
      }
      _openFile(filePath);
      emit(MessageMediaDownloaded(downloadedDocIds));
    } else {
      emit(MessageMediaLoading());
      await _downloadFile(event.message.url, event.message.fileName);
      emit(MessageMediaDownloaded(downloadedDocIds));
      downloadedDocIds.add(event.message.dcoId ?? "");
      PrefUtils.setDownloadedDocId(downloadedDocIds);
    }
  }

  _downloadFile(docUrl, fileName) async {
    final dio = Dio();
    String filePath = await _getFilePath(fileName);
    await dio.download(
      docUrl,
      filePath,
      onReceiveProgress: (received, total) {},
    );
  }

  Future<String?> _isFileDownloaded(String fileName) async {
    var filePath = await _getFilePath(fileName);
    File file = File(filePath);
    if (await file.exists()) {
      return filePath;
    } else {
      return null;
    }
  }

  _openFile(String filePath) async {
    await OpenFile.open(filePath);
  }

  Future<String> _getFilePath(String fileName) async {
    if (Platform.isIOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      return '${documentsDirectory.path}/$fileName';
    } else {
      Directory dir;
      dir = Directory('/storage/emulated/0/Download/');
      return '${dir.path}/$fileName';
    }
  }
}
