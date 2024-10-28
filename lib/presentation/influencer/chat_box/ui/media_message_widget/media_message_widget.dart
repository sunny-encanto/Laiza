import 'package:intl/intl.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:laiza/presentation/influencer/chat_box/ui/media_message_widget/bloc/message_media_bloc.dart';
import 'package:laiza/presentation/influencer/chat_box/ui/video_message_widget.dart/video_message.dart';

import '../../../../../core/utils/pref_utils.dart';
import '../image_message_widget/image_message_widget.dart';

class MediaMessageWidget extends StatelessWidget {
  final Message message;
  const MediaMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return isImage(message.fileExtension!)
        ? ImageMessageWidget(message: message)
        : message.fileExtension == '.mp4'
            ? VideoMessageWidget(message: message)
            : docsWidget(context);
  }

  Widget docsWidget(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Align(
        alignment: message.senderId == PrefUtils.getId()
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: SizedBox(
          width: SizeUtils.width * 0.6,
          child: Column(
            crossAxisAlignment: message.senderId == PrefUtils.getId()
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Card(
                color: message.senderId == PrefUtils.getId()
                    ? AppColor.primary
                    : AppColor.offWhite,
                child: ListTile(
                  minLeadingWidth: 12.h,
                  contentPadding: EdgeInsets.all(5.h),
                  leading: Icon(
                    Icons.insert_drive_file,
                    color: message.senderId == PrefUtils.getId()
                        ? AppColor.offWhite
                        : AppColor.primary,
                  ),
                  title: Text(
                    message.fileName ?? "",
                    style: TextStyle(
                      color: message.senderId == PrefUtils.getId()
                          ? AppColor.offWhite
                          : AppColor.primary,
                    ),
                  ),
                  trailing: message.url!.isEmpty
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: const CircularProgressIndicator())
                      : _getTrailing(message),
                ),
              ),
              SizedBox(height: 5.h),
              message.senderId == PrefUtils.getId()
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            DateFormat('hh:mm a').format(
                                DateTime.parse(message.timestamp ?? '')),
                            style: textTheme.bodySmall),
                        SizedBox(width: 5.h),
                        Container(
                          decoration: message.isSeen ?? false
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary)
                              : null,
                          child: Icon(
                            Icons.done,
                            size: 12.h,
                            color: message.isSeen ?? false
                                ? Colors.white
                                : Colors.grey,
                          ),
                        )
                      ],
                    )
                  : Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(message.timestamp ?? '')),
                      style: textTheme.bodySmall),
            ],
          ),
        ));
  }

  Widget _getTrailing(Message message) {
    return BlocProvider(
      create: (context) => MessageMediaBloc(),
      child: BlocBuilder<MessageMediaBloc, MessageMediaState>(
        builder: (context, state) {
          if (state is MessageMediaInitial) {
            return IconButton(
              icon: Icon(
                !PrefUtils.getDownloadedDocId().contains(message.dcoId)
                    ? Icons.download
                    : Icons.file_open,
                color: message.senderId == PrefUtils.getId()
                    ? AppColor.offWhite
                    : AppColor.primary,
              ),
              onPressed: () async {
                context
                    .read<MessageMediaBloc>()
                    .add(MedialMessageDownloadOrOpenEvent(message));
              },
            );
          } else if (state is MessageMediaLoading) {
            return SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator());
          } else if (state is MessageMediaDownloaded) {
            return IconButton(
              icon: Icon(
                Icons.file_open,
                color: message.senderId == PrefUtils.getId()
                    ? AppColor.offWhite
                    : AppColor.primary,
              ),
              onPressed: () async {
                context
                    .read<MessageMediaBloc>()
                    .add(MedialMessageDownloadOrOpenEvent(message));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

isImage(String fileExtension) {
  List imageExtensions = ['.image', '.jpg', '.png', '.jpeg', '.gif'];
  return imageExtensions.contains(fileExtension.toLowerCase());
}
