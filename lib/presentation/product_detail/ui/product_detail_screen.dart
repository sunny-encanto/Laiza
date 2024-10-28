import 'package:laiza/core/app_export.dart';
import 'package:readmore/readmore.dart';

import '../../../data/services/share.dart';
import '../../../widgets/slider_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  int _currentIndex = 0;
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.v),
              customSlider(
                  autoPlay: false,
                  height: 300.v,
                  onPageChanged: (index, reason) {
                    _currentIndex = index;
                    context
                        .read<ProductDetailBloc>()
                        .add(OnPageChangedEvent(index));
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
                          buildWhen: (previous, current) =>
                              current is OnPageChangedState,
                          listener:
                              (BuildContext context, ProductDetailState state) {
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
                                  width:
                                      _currentIndex == dotIndex ? 30.h : 10.h,
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
                  ]),

              SizedBox(height: 20.v),
              //Product Title
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Classic  Sneakers – Minimalist Design, Maximum Comfort',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
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
                            context
                                .read<ProductDetailBloc>()
                                .add(ProductLikeToggleEvent(!_isLiked));
                          },
                          icon: Icon(
                            _isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: _isLiked ? Colors.red : AppColor.primary,
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
                              '₹ 2,799',
                              style: textTheme.titleMedium!
                                  .copyWith(fontSize: 20.fSize),
                            ),
                            SizedBox(width: 2.h),
                            Text(
                              '15% Off, You Save ₹525!',
                              style: textTheme.bodySmall!,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'In Stock – Limited quantities available!',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  CustomImageView(
                    onTap: () async {
                      await shareContent('Share');
                    },
                    imagePath: ImageConstant.shareIcon,
                    color: Colors.black,
                  )
                ],
              ),
              SizedBox(height: 8.h),
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
              Row(
                children: List.generate(
                  5,
                  (index) =>
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
                          height: 48.v,
                          width: 48.h,
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
                            '${index + 1}',
                            style: textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Colors',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 12.h),
              Row(
                children: List.generate(
                  colorsList.length,
                  (index) =>
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
                              color: colorsList[index],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Features',
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    'View',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 12.v),
              Column(
                children: List.generate(
                  featureList.length,
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
                        Text(
                          featureList[index],
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              const Divider(),
              SizedBox(height: 12.v),
              Text(
                'Delivery & Return Details',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 12.v),
              CustomTextFormField(
                hintText: 'Pin Code',
                suffix: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: 22.v, right: 12.h),
                    child: Text(
                      'Check Delivery Date',
                      style: textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: AppColor.offWhite,
              //     borderRadius: BorderRadius.circular(12.h),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.all(12.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           '465445',
              //           style: textTheme.titleMedium,
              //         ),
              // Text(
              //   'Check Delivery Date',
              //   style: textTheme.bodySmall,
              // ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 16.v),
              Column(
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.shippingIcon,
                      ),
                      SizedBox(width: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping & Delivery Estimation',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 4.v),
                          SizedBox(
                            width: SizeUtils.width - 100.h,
                            child: Text(
                              'Order today and get it by Sept 23 – Free Shipping!',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 12.v),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.shippingIcon1,
                      ),
                      SizedBox(width: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping & Delivery Estimation',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 4.v),
                          SizedBox(
                            width: SizeUtils.width - 100.h,
                            child: Text(
                              '30-Day Free Returns – Get a full refund or exchange within 30 days of purchase.',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.v),
              const Divider(),
              SizedBox(height: 12.v),
              Text(
                'Customer Reviews & Ratings',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 28.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '4.1',
                            style: textTheme.titleMedium!
                                .copyWith(fontSize: 36.fSize),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Text(
                        '1k Ratings',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(width: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Words',
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'How was the product fit?',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(width: 12.h),
                          Text(
                            'Perfect',
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Quality',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(width: 12.h),
                          Text(
                            'Very Good',
                            style: textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 120.v),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.v),
        child: Row(
          children: [
            Expanded(
                child: CustomOutlineButton(
                    leftIcon: CustomImageView(
                      imagePath: ImageConstant.cartBlackIcon,
                    ),
                    onPressed: () {},
                    text: 'Add to Cart')),
            SizedBox(width: 12.h),
            Expanded(
                child: CustomElevatedButton(
                    leftIcon: CustomImageView(
                      imagePath: ImageConstant.checkOut,
                    ),
                    onPressed: () {},
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
                'Tip : If you dont find an exact match, go for the next size',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List colorsList = [
    AppColor.lightPink,
    AppColor.blackColor,
    AppColor.brownColor,
    Colors.yellow
  ];
  List featureList = [
    ' Material: 100% Premium Leather Upper',
    'Sole: Lightweight Rubber Sole for Extra Comfort',
    'Style: Low-top, Lace-up Closure',
    'Comfort: Padded Insole for Maximum Cushioning',
    'Fit: True to Size',
  ];
}
