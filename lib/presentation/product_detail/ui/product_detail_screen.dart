import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/rating_model/rating_model.dart';

import '../../../data/services/helper_services.dart';
import '../../../data/services/share.dart';
import '../../../widgets/slider_widget.dart';
import '../../shimmers/product_details_loading_screen.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  final int id;

  ProductDetailScreen({super.key, required this.id});

  bool _isLiked = false;
  int _selectedSize = 1;
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppColor.offWhite,
        title: Text(
          'Product Detail',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
        actions: [
          CustomIconButton(
              icon: ImageConstant.cartIcon,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              }),
          SizedBox(width: 5.h)
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          buildWhen: (previous, current) => (current is ProductDetailLoading ||
              current is ProductDetailLoaded ||
              current is ProductDetailError),
          builder: (context, state) {
            if (state is ProductDetailInitial) {
              context.read<ProductDetailBloc>().add(ProductDetailLoadEvent(id));
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailLoading) {
              return const ProductDetailsLoadingScreen();
            } else if (state is ProductDetailError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ProductDetailLoaded) {
              final Product product = state.product;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.v),

                    ///Slider
                    BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      buildWhen: (previous, current) =>
                          current is OnPageChangedState,
                      builder: (context, state) {
                        if (state is OnPageChangedState) {
                          return Column(
                            children: [
                              customSlider(
                                  autoPlay: false,
                                  height: 300.v,
                                  onPageChanged: (index, reason) {
                                    context
                                        .read<ProductDetailBloc>()
                                        .add(OnPageChangedEvent(index));
                                  },
                                  childList: List.generate(
                                    product.images.length,
                                    (index) => CustomImageView(
                                      width: SizeUtils.width,
                                      height: 300.v,
                                      imagePath:
                                          product.images[state.index].imagePath,
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  product.images.length,
                                  (dotIndex) => Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.h, vertical: 10.v),
                                    height: 7.v,
                                    width:
                                        state.index == dotIndex ? 30.h : 10.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.h),
                                      color: state.index == dotIndex
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            customSlider(
                                autoPlay: false,
                                height: 300.v,
                                onPageChanged: (index, reason) {
                                  context
                                      .read<ProductDetailBloc>()
                                      .add(OnPageChangedEvent(index));
                                },
                                childList: List.generate(
                                  product.images.length,
                                  (index) => CustomImageView(
                                    width: SizeUtils.width,
                                    height: 300.v,
                                    imagePath: product.images[0].imagePath,
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                product.images.length,
                                (dotIndex) => Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.h, vertical: 10.v),
                                  height: 7.v,
                                  width: 0 == dotIndex ? 30.h : 10.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.h),
                                    color: 0 == dotIndex
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 20.v),
                    //Product Title
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.product.productName,
                            style: textTheme.titleMedium!
                                .copyWith(fontSize: 16.fSize),
                          ),
                        ),
                        // Like Button
                        BlocConsumer<ProductDetailBloc, ProductDetailState>(
                          listener: (context, state) {
                            if (state is ProductLikeToggleState) {
                              _isLiked = state.isLiked;
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                                onPressed: () {
                                  context.read<ProductDetailBloc>().add(
                                      ProductLikeToggleEvent(
                                          id: product.id, isLiked: !_isLiked));
                                },
                                icon: Icon(
                                  _isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color:
                                      _isLiked ? Colors.red : AppColor.primary,
                                ));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 11.v),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹${product.price}',
                                    style: textTheme.titleMedium!
                                        .copyWith(fontSize: 20.fSize),
                                  ),
                                  // SizedBox(width: 2.h),
                                  // Text(
                                  //   '${product.coupons[0].title} % Off, You Save ₹525!',
                                  //   style: textTheme.bodySmall!,
                                  // ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              product.stockQuantity > 0
                                  ? Text(
                                      'In Stock – Limited quantities available!',
                                      style: textTheme.bodySmall,
                                    )
                                  : Text(
                                      'Out of Stock',
                                      style: textTheme.bodySmall!
                                          .copyWith(color: Colors.red),
                                    ),
                            ],
                          ),
                        ),
                        CustomImageView(
                          onTap: () async {
                            await shareContent(
                                '${ApiConstant.baseUrlWeb}/product?id=${product.id}');
                          },
                          imagePath: ImageConstant.shareIcon,
                          color: Colors.black,
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
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
                    //   trimCollapsedText: ' Read more',
                    //   trimExpandedText: ' Read less',
                    //   moreStyle:
                    //       textTheme.bodySmall!.copyWith(color: Colors.black),
                    // ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Size',
                          style: textTheme.titleMedium,
                        ),
                        InkWell(
                          onTap: () {
                            _showSizeChart(context, textTheme);
                          },
                          child: Text(
                            'Size Chart',
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 48.v,
                      child: ListView.builder(
                        itemCount: product.availableSize.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BlocConsumer<ProductDetailBloc, ProductDetailState>(
                          listener: (context, state) {
                            if (state is ProductSizeChangeState) {
                              _selectedSize = state.size;
                            }
                          },
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<ProductDetailBloc>()
                                    .add(ProductSizeChangeEvent(index + 1));
                              },
                              child: Container(
                                constraints: BoxConstraints(minWidth: 48.h),
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                height: 48.v,
                                margin: EdgeInsets.only(right: 8.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _selectedSize == index + 1
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(6.h)),
                                child: Text(
                                  product.availableSize[index],
                                  style: textTheme.titleMedium,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    /// Colors Selection
                    SizedBox(height: 24.h),
                    Text(
                      'Colors',
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 48.v,
                      child: ListView.builder(
                        itemCount: product.availableColor.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BlocConsumer<ProductDetailBloc, ProductDetailState>(
                          listener: (context, state) {
                            if (state is ProductColorChangeState) {
                              _selectedColor = state.color;
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              height: 48.v,
                              width: 48.h,
                              margin: EdgeInsets.only(right: 15.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedColor == index
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<ProductDetailBloc>()
                                      .add(ProductColorChangeEvent(index));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(3.h),
                                  decoration: BoxDecoration(
                                    color: hexToColor(
                                        product.availableColor[index]),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    /// Product Features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Features',
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.v),
                    Column(
                      children: List.generate(
                        product.features.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 12.v),
                          child: Row(
                            children: [
                              Container(
                                width: 5.h,
                                height: 5.v,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                              ),
                              SizedBox(width: 5.h),
                              Expanded(
                                child: Text(
                                  product.features[index],
                                  style: textTheme.bodySmall,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.v),
                    const Divider(),
                    SizedBox(height: 12.v),

                    ///
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomImageView(imagePath: ImageConstant.returns),
                            SizedBox(height: 12.v),
                            Text(
                              '30-Day Free\nReturns/Exchange ',
                              style: textTheme.bodySmall!.copyWith(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CustomImageView(imagePath: ImageConstant.secure),
                            SizedBox(height: 12.v),
                            Text(
                              'Secure\ntransaction',
                              style: textTheme.bodySmall!.copyWith(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CustomImageView(imagePath: ImageConstant.brands),
                            SizedBox(height: 12.v),
                            Text(
                              'Top\nBrands',
                              style: textTheme.bodySmall!.copyWith(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.v),
                    const Divider(),

                    /// Additional Information
                    SizedBox(height: 12.v),
                    _buildAdditionInfo(context, product.additionalInfo),
                    // Text(
                    //   'Delivery & Return Details',
                    //   style: textTheme.titleMedium,
                    // ),
                    // SizedBox(height: 12.v),
                    // CustomTextFormField(
                    //   hintText: 'Pin Code',
                    //   suffix: SizedBox(
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 22.v, right: 12.h),
                    //       child: Text(
                    //         'Check Delivery Date',
                    //         style: textTheme.bodySmall,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 16.v),

                    SizedBox(height: 12.v),
                    const Divider(),
                    SizedBox(height: 12.v),

                    _buildRatingAndReview(textTheme, product),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Text(
                    //               '4.1',
                    //               style: textTheme.titleMedium!
                    //                   .copyWith(fontSize: 36.fSize),
                    //             ),
                    //             const Icon(
                    //               Icons.star,
                    //               color: Colors.black,
                    //             )
                    //           ],
                    //         ),
                    //         Text(
                    //           '1k Ratings',
                    //           style: textTheme.bodySmall,
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(width: 16.h),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'Customer Words',
                    //           style: textTheme.titleMedium,
                    //         ),
                    //         SizedBox(height: 12.h),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'How was the product fit?',
                    //               style: textTheme.bodySmall,
                    //             ),
                    //             SizedBox(width: 12.h),
                    //             Text(
                    //               'Perfect',
                    //               style: textTheme.titleMedium,
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 8.h),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'Product Quality',
                    //               style: textTheme.bodySmall,
                    //             ),
                    //             SizedBox(width: 12.h),
                    //             Text(
                    //               'Very Good',
                    //               style: textTheme.titleMedium,
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    // SizedBox(height: 120.v),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.v),
        child: Row(
          children: [
            Expanded(
                child: BlocListener<ProductDetailBloc, ProductDetailState>(
              listener: (context, state) {
                if (state is ProductAddedToCart) {
                  context.showSnackBar(state.message);
                } else if (state is ProductAddedToCartError) {
                  context.showSnackBar(state.message);
                }
              },
              child: CustomOutlineButton(
                  leftIcon: CustomImageView(
                    imagePath: ImageConstant.cartBlackIcon,
                  ),
                  onPressed: () {
                    context.read<ProductDetailBloc>().add(ProductAddToCart(id));
                  },
                  text: 'Add to Cart'),
            )),
            SizedBox(width: 12.h),
            Expanded(
                child: CustomElevatedButton(
                    leftIcon: CustomImageView(
                      imagePath: ImageConstant.checkOut,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.addAddressScreen);
                    },
                    text: 'Check Out')),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showSizeChart(BuildContext context, TextTheme textTheme) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300.v,
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Foot Measurement(cm)',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 20.v),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Text('Size(UK)',
                                style: textTheme.titleMedium))),
                    TableCell(
                        child: Center(
                            child: Text('Brand Size(UK)',
                                style: textTheme.titleMedium))),
                    TableCell(
                        child: Center(
                            child: Text('Foot Length',
                                style: textTheme.titleMedium))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Text('20', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('30', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('40', style: textTheme.bodySmall))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Text('10', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('15', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('30', style: textTheme.bodySmall))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Text('10', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('15', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('30', style: textTheme.bodySmall))),
                  ]),
                  TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Text('10', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('15', style: textTheme.bodySmall))),
                    TableCell(
                        child: Center(
                            child: Text('30', style: textTheme.bodySmall))),
                  ]),
                ],
              ),
              SizedBox(height: 5.v),
              Text(
                "Tip : If you don't find an exact match, go for the next size",
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAdditionInfo(
      BuildContext context, ProductAdditionalInfo? additionalInfo) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return additionalInfo == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // padding: const EdgeInsets.all(16.0),
            children: [
              // Additional Information Section
              Text('Additional Information', style: textTheme.titleMedium),
              SizedBox(height: 16.v),
              buildInfoRow(
                  'Manufacturer', additionalInfo.manufacture, textTheme),
              buildInfoRow('Packer', additionalInfo.packer, textTheme),
              buildInfoRow('Importer', additionalInfo.importer, textTheme),
              buildInfoRow('Item Weight', additionalInfo.itemWeight, textTheme),
              buildInfoRow('Item Dimensions LxWxH',
                  additionalInfo.itemDimensions, textTheme),
              buildInfoRow(
                  'Net Quantity', additionalInfo.netQuantity, textTheme),
              buildInfoRow(
                  'Generic Name', additionalInfo.genericName, textTheme),
              const SizedBox(height: 24),
            ],
          );
  }

  _buildRatingAndReview(TextTheme textTheme, Product product) {
    return Column(
      children: [
        // Customer Reviews & Ratings Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Reviews & Ratings',
              style: textTheme.titleMedium,
            ),
            Row(
              children: [
                Icon(Icons.star, color: AppColor.primary, size: 20.h),
                SizedBox(width: 4.h),
                Text('${product.averageRating}', style: textTheme.bodySmall),
                Text(
                  '(${product.totalRatings} Ratings)',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(
          product.ratings.length,
          (index) => buildReviewCard(product.ratings[index], textTheme),
        )
      ],
    );
  }

  Widget buildInfoRow(String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: textTheme.bodySmall!.copyWith(fontSize: 12.fSize)),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label:  ',
                style: textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: value,
                    style: textTheme.bodySmall!.copyWith(fontSize: 14.fSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewCard(Rating rating, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rating.user.name ?? '', style: textTheme.titleMedium),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating.rating ? Icons.star : Icons.star_border,
                    color: AppColor.primary,
                    size: 20,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(rating.review, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
