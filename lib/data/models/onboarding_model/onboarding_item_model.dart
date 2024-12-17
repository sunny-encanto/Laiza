import 'package:laiza/core/utils/image_constant.dart';

class OnboardingItmes {
  final String image;
  final String title;
  final String subTitle;

  OnboardingItmes(
      {required this.image, required this.title, required this.subTitle});
}

List<OnboardingItmes> onboardingItemsList = <OnboardingItmes>[
  OnboardingItmes(
      image: ImageConstant.intro3,
      title: 'Grow Your Influence & Sales Today',
      subTitle:
          'Browse trending products, watch live streams, and shop with ease'),
  OnboardingItmes(
      image: ImageConstant.intro1,
      title: 'Experience Real-Time Shopping Delight',
      subTitle:
          'Partner with sellers, promote products, and earn while doing what you love'),
  OnboardingItmes(
      image: ImageConstant.intro2,
      title: 'Streamline Sales with Live Shopping',
      subTitle:
          'List products, connect with top influencers, and manage orders seamlessly on Laiza'),
];
