import '../../../core/app_export.dart';

class EmptyWishlistScreen extends StatelessWidget {
  const EmptyWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 180.h,
        imagePath: ImageConstant.emptyWishlist,
      ),
    );
  }
}
