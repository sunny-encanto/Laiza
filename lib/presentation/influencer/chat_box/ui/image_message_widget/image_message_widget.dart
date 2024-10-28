import 'package:intl/intl.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/message/message_model.dart';
import 'package:photo_view/photo_view.dart';

class ImageMessageWidget extends StatelessWidget {
  final Message message;
  const ImageMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.senderId == PrefUtils.getId()
        ? _buildRightWidget(context)
        : _buildLeftWidget(context);
  }

  Align _buildLeftWidget(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: message.url!.isEmpty
          ? loadingWidget(textTheme)
          : Padding(
              padding: EdgeInsets.only(top: 10.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.viewImageWidget,
                              arguments: message.url);
                        },
                        fit: BoxFit.cover,
                        border:
                            Border.all(color: AppColor.offWhite, width: 2.h),
                        width: SizeUtils.width * 0.4,
                        height: 160.adaptSize,
                        imagePath: message.url,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(message.timestamp ?? '')),
                      style: textTheme.bodySmall)
                ],
              ),
            ),
    );
  }

  Align _buildRightWidget(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerRight,
      child: message.url!.isEmpty
          ? loadingWidget(textTheme)
          : Padding(
              padding: EdgeInsets.only(top: 10.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomImageView(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.viewImageWidget,
                              arguments: message.url);
                        },
                        fit: BoxFit.cover,
                        border: Border.all(color: AppColor.primary, width: 2.h),
                        width: SizeUtils.width * 0.4,
                        height: 160.adaptSize,
                        imagePath: message.url,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(message.timestamp ?? '')),
                          style: textTheme.bodySmall),
                      SizedBox(width: 5.h),
                      Container(
                        decoration: message.isSeen ?? false
                            ? BoxDecoration(
                                shape: BoxShape.circle, color: AppColor.primary)
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
                ],
              ),
            ),
    );
  }

  Widget loadingWidget(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: message.senderId == PrefUtils.getId()
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.v),
          alignment: Alignment.center,
          width: SizeUtils.width * 0.4,
          height: 160.adaptSize,
          decoration: BoxDecoration(
            border: Border.all(
                color: message.senderId == PrefUtils.getId()
                    ? AppColor.primary
                    : AppColor.offWhite,
                width: 2.v),
            borderRadius: BorderRadius.circular(5.fSize),
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

class ViewImageWidget extends StatelessWidget {
  const ViewImageWidget({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: AppColor.offWhite)),
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
