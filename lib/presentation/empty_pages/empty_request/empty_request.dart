import '../../../core/app_export.dart';

class EmptyRequestScreen extends StatelessWidget {
  const EmptyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 280.h,
        imagePath: ImageConstant.noRequestFound,
      ),
    );
  }
}
