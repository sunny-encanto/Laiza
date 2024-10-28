import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../../../data/models/onboarding_model/onboarding_item_model.dart';
import '../cubit/page_view_cubit.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => PageViewCubit(itemCount: 3),
      child: Scaffold(
        body: BlocBuilder<PageViewCubit, int>(
          builder: (context, currentIndex) {
            return Stack(
              children: [
                AnimatedSwitcher(
                  switchInCurve: Curves.bounceInOut,
                  switchOutCurve: Curves.bounceInOut,
                  duration:
                      const Duration(milliseconds: 500), // Animation duration
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0), // From right to left
                      end: const Offset(0.0, 0.0),
                    ).animate(animation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  child: CustomImageView(
                    fit: BoxFit.cover,
                    width: SizeUtils.width,
                    height: SizeUtils.height,
                    imagePath: onboardingItmesList[currentIndex].image,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6854, 0.7707],
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0),
                        Color.fromRGBO(215, 215, 215, 0.75),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(onboardingItmesList[currentIndex].title,
                                textAlign: TextAlign.center,
                                style: textTheme.titleLarge!
                                    .copyWith(color: Colors.white)),
                            SizedBox(height: 20.v),
                            Text(onboardingItmesList[currentIndex].subTitle,
                                textAlign: TextAlign.center,
                                style: textTheme.titleLarge!.copyWith(
                                    fontSize: 16.fSize, color: Colors.black)),
                          ],
                        ),
                      ),
                      SizedBox(height: 46.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: CustomElevatedButton(
                          text: 'Get Started',
                          onPressed: () {
                            PrefUtils.setIsNewUser(false);
                            Navigator.of(context).pushReplacementNamed(
                                AppRoutes.selectRoleScreen);
                          },
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: EdgeInsets.all(2.h),
                            height: 10.h,
                            width: 10.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? AppColor.primary
                                    : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.v),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
