import 'package:intl/intl.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:laiza/presentation/video_player/ui/video_player.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/pref_utils.dart';

class VideoMessageWidget extends StatelessWidget {
  const VideoMessageWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Align(
        alignment: message.senderId == PrefUtils.getId()
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: message.thumbnailUrl!.isEmpty
            ? loadingWidget(textTheme)
            : Padding(
                padding: EdgeInsets.only(top: 10.v),
                child: Column(
                  crossAxisAlignment: message.senderId == PrefUtils.getId()
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: SizeUtils.width * 0.4,
                          height: 160.adaptSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(message.thumbnailUrl ?? '')),
                            border: Border.all(
                                color: message.senderId == PrefUtils.getId()
                                    ? AppColor.primary
                                    : AppColor.offWhite,
                                width: 1.v),
                            // borderRadius: BorderRadius.circular(10.fSize),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const VideoPlayerWidget(
                                  videoUrl:
                                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.v),
                            decoration: BoxDecoration(color: AppColor.primary),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
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
                            DateFormat('hh:mm a').format(
                                DateTime.parse(message.timestamp ?? '')),
                            style: textTheme.bodySmall),
                  ],
                ),
              )
        //: loadingWidget(),
        );
  }

  Widget loadingWidget(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: message.senderId == PrefUtils.getId()
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.v),
          alignment: Alignment.center,
          width: SizeUtils.width * 0.4,
          height: 160.adaptSize,
          decoration: BoxDecoration(
            border: Border.all(
                color: message.senderId == PrefUtils.getId()
                    ? AppColor.primary
                    : AppColor.offWhite,
                width: 1.v),
          ),
          child: CircularProgressIndicator(
            backgroundColor: AppColor.primary,
          ),
        ),
        SizedBox(height: 5.h),
        message.senderId == PrefUtils.getId()
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(message.timestamp ?? '')),
                      style: textTheme.bodySmall),
                  SizedBox(width: 5.h),
                  Container(
                    padding: EdgeInsets.all(3.h),
                    decoration: message.isSeen ?? false
                        ? BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.primary)
                        : null,
                    child: CustomImageView(
                      imagePath: ImageConstant.pendingMessage,
                    ),
                  )
                ],
              )
            : Text(
                DateFormat('hh:mm a')
                    .format(DateTime.parse(message.timestamp ?? '')),
                style: textTheme.bodySmall),
      ],
    );
  }
}
