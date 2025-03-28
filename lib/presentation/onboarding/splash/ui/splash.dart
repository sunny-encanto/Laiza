import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            if (PrefUtils.getId().isNotEmpty) {
              if (PrefUtils.getRole() == UserRole.user.name) {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.bottomBarScreen);
              } else {
                if (PrefUtils.getIsFormComplete()) {
                  if (PrefUtils.getIsApproved()) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.homeScreen);
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.successScreen);
                  }
                } else {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.influencerFormScreen);
                }
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
        child: CustomImageView(
          width: SizeUtils.width,
          height: SizeUtils.height,
          imagePath: ImageConstant.laizaVideo,
        ),
      ),
    );
  }
}
