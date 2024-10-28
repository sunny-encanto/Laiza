import 'package:laiza/core/app_export.dart';
import 'package:readmore/readmore.dart';

import '../../../../widgets/slider_widget.dart';

class SellerInfoScreen extends StatelessWidget {
  SellerInfoScreen({super.key});
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details & Seller Info',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductSlider(context),
              SizedBox(height: 20.v),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Classic  Sneakers – Minimalist Design, Maximum Comfort',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.favorite_border))
                ],
              ),
              SizedBox(height: 20.v),
              ReadMoreText(
                'Step into timeless style with these ultra-comfortable white sneakers. Perfect for any casual occasion, offering a sleek look with premium materials for...',
                style: textTheme.bodySmall,
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: Colors.black,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                moreStyle: textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Product Category- ',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        'Footwear',
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.productDetailScreen);
                    },
                    child: Text(
                      'More Details',
                      style: textTheme.bodySmall!
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                children: [
                  Text(
                    'Promotion Pricing- ',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    '₹4000-8000',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                children: [
                  Text(
                    'Product Price- ',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    '₹2,799',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.h,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.h),
                  Expanded(
                    child: Text(
                      'To promote the product first You need to connect with the seller',
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.v),
              Text(
                'Seller Profile and Business Details',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 12.v),
              Row(
                children: [
                  CustomImageView(
                    height: 100.h,
                    width: 100.h,
                    radius: BorderRadius.circular(100.h),
                    border: Border.all(color: Colors.black),
                    imagePath: ImageConstant.bannerGirl,
                  ),
                  SizedBox(width: 16.v),
                  Column(
                    children: [
                      Text(
                        'Shubham Deep',
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(height: 12.v),
                      CustomElevatedButton(
                        width: 146.h,
                        height: 32.v,
                        text: 'Connect',
                        buttonTextStyle: textTheme.titleSmall,
                        leftIcon: CustomImageView(
                          imagePath: ImageConstant.personAdd,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.chatIcon,
                  )
                ],
              ),
              SizedBox(height: 12.v),
              Row(
                children: [
                  CustomImageView(imagePath: ImageConstant.businessIcon),
                  SizedBox(width: 2.v),
                  Text(
                    'Business type- ',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    'Footwear Retailer',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                children: [
                  CustomImageView(imagePath: ImageConstant.firmIcon),
                  SizedBox(width: 2.v),
                  Text(
                    'Firm name- ',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    'WalkWell Footwear',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                children: [
                  CustomImageView(imagePath: ImageConstant.locationIcon1),
                  SizedBox(width: 2.v),
                  Text(
                    'Location- ',
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    'Mumbai, Maharashtra',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 12.v),
              Text(
                'WalkWell Footwear, founded in 2014, specializes in stylish and affordable footwear for every occasion. We combine comfort, quality, and the latest trends to deliver a range of shoes, from casual to formal.With a loyal customer base and a focus on innovative designs, our mission is to make fashion accessible without compromising on quality. We look forward to collaborating with influencers who share our passion for style and excellence.',
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 16.v),
              Text(
                'Business Goals',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 4.v),
              Text(
                'Our primary objective is to expand our brand presence in the fashion and footwear market. We aim to:',
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 12.v),
              Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 8.v),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.v),
                          height: 7.h,
                          width: 7.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                        ),
                        SizedBox(width: 5.v),
                        Expanded(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Increase Brand Awareness:',
                                  style: textTheme.titleMedium,
                                  children: [
                                TextSpan(
                                  text:
                                      'We want to reach a wider audience by collaborating with influencers who can showcase our footwear collections through engaging content, such as styling tips, unboxing videos, and live promotions.',
                                  style: textTheme.bodySmall,
                                )
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.v),
              Text(
                'Other products from Walkwell Footwear',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 12.v),
              _buildOtherProduct(textTheme),
              SizedBox(height: 32.v),
              const CustomOutlineButton(text: 'View More')
            ],
          ),
        ),
      ),
    );
  }

  GridView _buildOtherProduct(TextTheme textTheme) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5.v,
        crossAxisSpacing: 5.h,
        childAspectRatio: 150.h / 291.v,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => _buildProductCart(textTheme),
    );
  }

  Widget _buildProductSlider(BuildContext context) {
    return customSlider(
        autoPlay: false,
        height: 300.v,
        onPageChanged: (index, reason) {
          _currentIndex = index;
          context.read<ProductDetailBloc>().add(OnPageChangedEvent(index));
        },
        childList: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //Product Image
              CustomImageView(
                width: SizeUtils.width,
                height: 300.v,
                imagePath: ImageConstant.productImage,
              ),
              BlocConsumer<ProductDetailBloc, ProductDetailState>(
                bloc: ProductDetailBloc(),
                buildWhen: (previous, current) => current is OnPageChangedState,
                listener: (BuildContext context, ProductDetailState state) {
                  if (state is OnPageChangedState) {
                    _currentIndex = state.index;
                  }
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (dotIndex) => Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.h, vertical: 10.v),
                        height: 7.v,
                        width: _currentIndex == dotIndex ? 30.h : 10.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: _currentIndex == dotIndex
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ]);
  }

  Container _buildProductCart(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.offWhite, borderRadius: BorderRadius.circular(12.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 185.v,
            radius: BorderRadius.circular(12.h),
            imagePath: ImageConstant.productImage,
          ),
          SizedBox(height: 4.v),
          Text(
            'Classic White Sneakers',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          Text(
            'by Shubham Deep',
            style: textTheme.bodySmall,
          ),
          SizedBox(height: 4.v),
          Row(
            children: [
              Text(
                'Category- ',
                style: textTheme.bodySmall,
              ),
              Text(
                'Footwear',
                style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
              ),
            ],
          ),
          SizedBox(height: 4.v),
          Row(
            children: [
              Text(
                'Promotion Pricing- ',
                style: textTheme.bodySmall,
              ),
              Expanded(
                child: Text(
                  '₹4K-8K',
                  style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.v),
          Center(
            child: CustomElevatedButton(
              height: 26.v,
              text: 'View Details',
              buttonTextStyle: textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
