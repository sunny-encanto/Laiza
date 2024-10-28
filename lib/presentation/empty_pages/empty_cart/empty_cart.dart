import '../../../core/app_export.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 180.h,
        imagePath: ImageConstant.noRequestFound,
      ),
    );
  }
}
