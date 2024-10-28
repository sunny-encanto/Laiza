import 'package:laiza/core/app_export.dart';

class NoOrdersFoundScreen extends StatelessWidget {
  const NoOrdersFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 280.h,
        imagePath: ImageConstant.noOrders,
      ),
    );
  }
}
