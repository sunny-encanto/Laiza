import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';

import '../../../../data/models/product_model/product.dart';
import '../../../../data/models/seller_details_model/seller_details_model.dart';
import '../../../../widgets/slider_widget.dart';

class SellerInfoScreen extends StatelessWidget {
  final String id;

  SellerInfoScreen({super.key, required this.id});

  int _currentIndex = 0;
  String isConnected = '';

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
      body: BlocBuilder<SellerInfoBloc, SellerInfoState>(
        buildWhen: (previous, current) => (current is SellerInfoLoading ||
            current is SellerInfoError ||
            current is SellerInfoLoaded),
        builder: (context, state) {
          if (state is SellerInfoInitial) {
            context.read<SellerInfoBloc>().add(FetchSellerInfo(id));
            return const Center(child: Center());
          } else if (state is SellerInfoLoading) {
            return const Center(child: Center());
          } else if (state is SellerInfoError) {
            return Center(child: Text(state.message));
          } else if (state is SellerInfoLoaded) {
            isConnected = state.sellerDetailsData.seller.connectionStatus;
            Product? product;
            if (state.sellerDetailsData.products.isNotEmpty) {
              product = state.sellerDetailsData.products[0];
            }

            Seller seller = state.sellerDetailsData.seller;
            return Padding(
              padding: EdgeInsets.all(20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product != null)
                      Column(
                        children: <Widget>[
                          _buildProductSlider(context, state.sellerDetailsData),
                          SizedBox(height: 20.v),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.productName,
                                  style: textTheme.titleMedium,
                                ),
                              ),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: const Icon(Icons.favorite_border))
                            ],
                          ),
                          SizedBox(height: 20.v),
                          HtmlWidget(
                            product.description,
                            // textStyle: const TextStyle(fontSize: 10),
                            renderMode: RenderMode.column,
                          ),
                          // ReadMoreText(
                          //   product.description,
                          //   style: textTheme.bodySmall,
                          //   trimMode: TrimMode.Line,
                          //   trimLines: 2,
                          //   colorClickableText: Colors.black,
                          //   trimCollapsedText: 'Read more',
                          //   trimExpandedText: 'Read less',
                          //   moreStyle:
                          //       textTheme.bodySmall!.copyWith(color: Colors.black),
                          // ),
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
                                    product.category.name ?? '',
                                    style: textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     Navigator.of(context)
                              //         .pushNamed(AppRoutes.productDetailScreen);
                              //   },
                              //   child: Text(
                              //     'More Details',
                              //     style: textTheme.bodySmall!
                              //         .copyWith(decoration: TextDecoration.underline),
                              //   ),
                              // ),
                            ],
                          ),
                          // SizedBox(height: 8.v),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Promotion Pricing- ',
                          //       style: textTheme.bodySmall,
                          //     ),
                          //     Text(
                          //       '₹${product.price}',
                          //       style: textTheme.titleMedium,
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 8.v),
                          Row(
                            children: [
                              Text(
                                'Product Price- ',
                                style: textTheme.bodySmall,
                              ),
                              Text(
                                '₹${product.price}',
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
                        ],
                      ),

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
                          imagePath: seller.profileImg,
                        ),
                        SizedBox(width: 16.v),
                        Column(
                          children: [
                            Text(
                              seller.name,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: 12.v),
                            BlocConsumer<SellerInfoBloc, SellerInfoState>(
                              listener: (context, state) {
                                if (state is SellerInfoAddConnection) {
                                  isConnected = state.isConnected.toString();
                                }
                              },
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  width: 146.h,
                                  height: 32.v,
                                  text: isConnected == "not_connected"
                                      ? 'Connect'
                                      : isConnected.capitalize(),
                                  //'Connect',
                                  buttonTextStyle: textTheme.titleSmall,
                                  leftIcon: CustomImageView(
                                    imagePath: ImageConstant.personAdd,
                                  ),
                                  onPressed: () {
                                    if (isConnected == "not_connected") {
                                      context.read<SellerInfoBloc>().add(
                                          SellerInfoAddConnectionEvent(
                                              isConnected: 'Pending',
                                              id: seller.id));
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        // const Spacer(),
                        // CustomImageView(
                        //   onTap: () {
                        //     // Navigator.of(context)
                        //     //     .pushNamed(AppRoutes.chatBoxScreen, arguments: '434');
                        //   },
                        //   imagePath: ImageConstant.chatIcon,
                        // )
                      ],
                    ),
                    SizedBox(height: 12.v),
                    Row(
                      children: [
                        CustomImageView(imagePath: ImageConstant.businessIcon),
                        SizedBox(width: 2.v),
                        Text(
                          'Brand name - ',
                          style: textTheme.bodySmall,
                        ),
                        Text(
                          seller.brandName,
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                    // SizedBox(height: 8.v),
                    // Row(
                    //   children: [
                    //     CustomImageView(imagePath: ImageConstant.firmIcon),
                    //     SizedBox(width: 2.v),
                    //     Text(
                    //       'Firm name- ',
                    //       style: textTheme.bodySmall,
                    //     ),
                    //     Text(
                    //       'WalkWell Footwear',
                    //       style: textTheme.titleMedium,
                    //     ),
                    //   ],
                    // ),
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
                          seller.permanentAddress,
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
                    HtmlWidget(
                      seller.buisnessGoals,
                      // textStyle: const TextStyle(fontSize: 10),
                      renderMode: RenderMode.column,
                    ),
                    // Text(
                    //   seller.buisnessGoals,
                    //   style: textTheme.bodySmall,
                    // ),

                    SizedBox(height: 32.v),
                    Text(
                      'Other products from Walkwell Footwear',
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 12.v),
                    _buildOtherProduct(
                        textTheme, state.sellerDetailsData.products),
                    SizedBox(height: 32.v),
                    // const CustomOutlineButton(text: 'View More')
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  GridView _buildOtherProduct(TextTheme textTheme, List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5.v,
        crossAxisSpacing: 5.h,
        childAspectRatio: 150.h / 291.v,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) =>
          _buildProductCart(context, products[index]),
    );
  }

  Widget _buildProductSlider(
      BuildContext context, SellerDetailsData sellerDetailsData) {
    return customSlider(
        autoPlay: false,
        height: 300.v,
        onPageChanged: (index, reason) {
          _currentIndex = index;
          context.read<ProductDetailBloc>().add(OnPageChangedEvent(index));
        },
        childList: List.generate(
          sellerDetailsData.products[0].images.length,
          (index) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //Product Image
              CustomImageView(
                width: SizeUtils.width,
                height: 300.v,
                imagePath:
                    sellerDetailsData.products[0].images[index].imagePath,
              ),
              BlocConsumer<ProductDetailBloc, ProductDetailState>(
                bloc: ProductDetailBloc(context.read<ProductRepository>()),
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
        ));
  }

  Container _buildProductCart(BuildContext context, Product product) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: AppColor.offWhite, borderRadius: BorderRadius.circular(12.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 185.v,
            radius: BorderRadius.circular(12.h),
            imagePath: product.productImage,
          ),
          SizedBox(height: 4.v),
          Text(
            product.productName,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          // Text(
          //
          //   'by Shubham Deep',
          //   style: textTheme.bodySmall,
          // ),
          SizedBox(height: 4.v),
          Row(
            children: [
              Text(
                'Category- ',
                style: textTheme.bodySmall,
              ),
              Text(
                product.category.name ?? '',
                style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
              ),
            ],
          ),
          SizedBox(height: 4.v),
          // Row(
          //   children: [
          //     Text(
          //       'Promotion Pricing- ',
          //       style: textTheme.bodySmall,
          //     ),
          //     Expanded(
          //       child: Text(
          //         '₹4K-8K',
          //         style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 12.v),
          Center(
            child: CustomElevatedButton(
              height: 26.v,
              text: 'View Details',
              buttonTextStyle: textTheme.titleSmall,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.productDetailScreen,
                    arguments: product.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
