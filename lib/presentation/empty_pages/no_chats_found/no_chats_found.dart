import '../../../core/app_export.dart';

class NoChatsFoundScreen extends StatelessWidget {
  const NoChatsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 280.h,
        imagePath: ImageConstant.noChatFound,
      ),
    );
  }
}
