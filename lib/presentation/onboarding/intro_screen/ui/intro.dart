import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../../../data/models/onboarding_model/onboarding_item_model.dart';
import '../cubit/page_view_cubit.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageViewCubit(itemCount: 3),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<PageViewCubit, int>(
            builder: (context, currentIndex) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: SizeUtils.width,
                    height: SizeUtils.height,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.wellComeTo,
                  ),
                  Visibility(
                    visible: currentIndex == 0,
                    child: Positioned(
                      top: 180.v,
                      left: 10.h,
                      child: Text(
                        'Shop Smarter \n Discover More'.toUpperCase(),
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 19.fSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: 0.02 * 22.0,
                          // Letter-spacing is absolute

                          decorationStyle: TextDecorationStyle.solid,

                          color: Colors
                              .black, // Set text color (can be customized)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentIndex == 1,
                    child: Positioned(
                      top: 200.v,
                      right: 20.h,
                      child: Text(
                        'Into \nRevenue'.toUpperCase(),
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 15.fSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: 0.02 * 22.0,
                          // Letter-spacing is absolute

                          decorationStyle: TextDecorationStyle.solid,

                          color: Colors
                              .black, // Set text color (can be customized)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentIndex == 1,
                    child: Positioned(
                      top: 200.v,
                      left: 10.h,
                      child: Text(
                        'Transform \nReach ',
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 15.fSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: 0.02 * 22.0,
                          // Letter-spacing is absolute

                          decorationStyle: TextDecorationStyle.solid,

                          color: Colors
                              .black, // Set text color (can be customized)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentIndex == 2,
                    child: Positioned(
                      top: 180.v,
                      left: 10.h,
                      child: Text(
                        'Grow Your\n Business with Ease'.toUpperCase(),
                        style: GoogleFonts.juliusSansOne(
                          fontSize: 19.fSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: 0.02 * 22.0,
                          // Letter-spacing is absolute

                          decorationStyle: TextDecorationStyle.solid,

                          color: Colors
                              .black, // Set text color (can be customized)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        // Slide transition
                        final slideAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0.0), // From right to left
                          end: const Offset(0.0, 0.0),
                        ).animate(animation);

                        // Scale transition
                        final scaleAnimation = Tween<double>(
                          begin: 0.8, // Start slightly smaller
                          end: 1.0, // End at normal size
                        ).animate(animation);

                        // Fade transition
                        final fadeAnimation = Tween<double>(
                          begin: 0.0, // Fully transparent
                          end: 1.0, // Fully opaque
                        ).animate(animation);

                        return SlideTransition(
                          position: slideAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: CustomImageView(
                        key: ValueKey<int>(currentIndex),
                        // Key to ensure proper widget rebuild
                        fit: BoxFit.contain,
                        width: SizeUtils.width,
                        height: SizeUtils.height - 250.h,
                        imagePath: onboardingItemsList[currentIndex].image,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: SizeUtils.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(ImageConstant.glassBg)),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.h),
                              topRight: Radius.circular(24.h)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 35.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    onboardingItemsList[currentIndex].subTitle,
                                    style: GoogleFonts.juliusSansOne(
                                      fontSize: 22.0.fSize,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                      letterSpacing: 0.02 * 22.0,
                                      // Letter-spacing is absolute
                                      decorationStyle:
                                          TextDecorationStyle.solid,

                                      color: Colors
                                          .black, // Set text color (can be customized)
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.v),
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
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
