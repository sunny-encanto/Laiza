import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CustomImageView(
                imagePath: ImageConstant.modern1,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CustomImageView(
                imagePath: ImageConstant.modern2,
              ),
            ),
            Column(
              children: [
                CustomImageView(width: 98.h, imagePath: ImageConstant.logo),
                SizedBox(height: 12.v),
                Text(
                  context.translate('welcome_laiza'),
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: 4.v),
                Text(
                  context.translate('discover_shop'),
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 25.v),
                CustomImageView(
                    onTap: () async {
                      await PrefUtils.setRole(UserRole.user.name);
                      Navigator.of(context).pushNamed(AppRoutes.signInScreen);
                    },
                    width: SizeUtils.width,
                    imagePath: ImageConstant.userCard),
                CustomImageView(
                    onTap: () async {
                      await PrefUtils.setRole(UserRole.influencer.name);
                      Navigator.of(context).pushNamed(AppRoutes.signInScreen);
                    },
                    width: SizeUtils.width,
                    imagePath: ImageConstant.influencerCard),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum UserRole { user, influencer }
