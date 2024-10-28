import '../../../core/app_export.dart';

class NoConnectionsFoundScreen extends StatelessWidget {
  const NoConnectionsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomImageView(
        width: SizeUtils.width - 250.h,
        imagePath: ImageConstant.noConnections,
      ),
    );
  }
}
