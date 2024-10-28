import '../../../core/app_export.dart';

class NoSearchFoundScreen extends StatelessWidget {
  const NoSearchFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 280.h,
        imagePath: ImageConstant.noSearchFound,
      ),
    );
  }
}
