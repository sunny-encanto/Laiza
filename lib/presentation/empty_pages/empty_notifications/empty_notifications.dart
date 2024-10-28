import 'package:laiza/core/app_export.dart';

class EmptyNotificationsScreen extends StatelessWidget {
  const EmptyNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CustomImageView(
            width: SizeUtils.width - 100.h,
            imagePath: ImageConstant.noNotifications,
          ),
        ),
        SizedBox(height: 10.v),
        Text(
          'No Notifications',
          style: textTheme.titleMedium!
              .copyWith(fontSize: 18.fSize, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
