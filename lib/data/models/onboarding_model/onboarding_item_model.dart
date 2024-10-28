import 'package:laiza/core/utils/image_constant.dart';

class OnboardingItmes {
  final String image;
  final String title;
  final String subTitle;

  OnboardingItmes(
      {required this.image, required this.title, required this.subTitle});
}

List<OnboardingItmes> onboardingItmesList = <OnboardingItmes>[
  OnboardingItmes(
      image: ImageConstant.influencer,
      title: 'Grow Your Influence & Sales Today',
      subTitle:
          'Showcase, engage, and boost your sales effortlessly on our live e-commerce platform.'),
  OnboardingItmes(
      image: ImageConstant.buyer,
      title: 'Experience Real-Time Shopping Delight',
      subTitle:
          'Discover products, interact live, and enjoy seamless shopping from your favorite streams.'),
  OnboardingItmes(
      image: ImageConstant.seller,
      title: 'Streamline Sales with Live Shopping',
      subTitle:
          'Showcase products, connect with buyers, and boost sales through live streaming.'),
];
