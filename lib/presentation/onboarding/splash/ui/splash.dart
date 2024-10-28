import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../../select_role/ui/select_role.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            if (PrefUtils.getId().isNotEmpty) {
              if (PrefUtils.getRole() == UserRole.User.name) {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.bottomBarScreen);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.homeScreen);
              }
            } else {
              if (PrefUtils.getIsNewUser()) {
                Navigator.pushReplacementNamed(context, AppRoutes.introScreen);
              } else {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.selectRoleScreen);
              }
            }
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomImageView(
                  imagePath: ImageConstant.modern1,
                ),
              ),
            ),
            CustomImageView(
              height: 171.v,
              imagePath: ImageConstant.logo,
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomImageView(
                  imagePath: ImageConstant.modern2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
