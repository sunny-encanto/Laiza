import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CustomImageView(
                        width: SizeUtils.width,
                        imagePath: ImageConstant.userCard),
                    Positioned(
                      bottom: 35.v,
                      left: 50.h,
                      child: CustomElevatedButton(
                        onPressed: () async {
                          await PrefUtils.setRole(UserRole.user.name);
                          Navigator.of(context)
                              .pushNamed(AppRoutes.signInScreen);
                        },
                        text: 'Get Started',
                        height: 25.v,
                        width: 128.h,
                        backgroundColor: Colors.white,
                        buttonTextStyle: TextStyle(
                            fontSize: 10.fSize,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    CustomImageView(
                        width: SizeUtils.width,
                        imagePath: ImageConstant.influencerCard),
                    Positioned(
                      bottom: 55.v,
                      right: 20.h,
                      child: CustomElevatedButton(
                        onPressed: () async {
                          await PrefUtils.setRole(UserRole.influencer.name);
                          Navigator.of(context)
                              .pushNamed(AppRoutes.signInScreen);
                        },
                        text: 'Get Started',
                        height: 25.v,
                        width: 128.h,
                        backgroundColor: Colors.white,
                        buttonTextStyle: TextStyle(
                            fontSize: 10.fSize,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
