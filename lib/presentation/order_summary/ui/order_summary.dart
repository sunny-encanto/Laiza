// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';

import '../../../data/models/cart_model/cart_model.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key});

  final TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Order Summary',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Address Box
              Container(
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.h),
                      width: 80.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12.h)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.home_outlined,
                              color: Colors.black45,
                            ),
                            Text(
                              'Home',
                              style: textTheme.titleSmall!
                                  .copyWith(color: Colors.black),
                            )
                          ]),
                    ),
                    SizedBox(height: 15.v),
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.shippingIcon,
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Address',
                                style: textTheme.titleMedium,
                              ),
                              CustomImageView(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.addAddressScreen);
                                },
                                imagePath: ImageConstant.editIcon,
                              )
                              // SizedBox(height: 4.v),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.v),
                    SizedBox(
                      width: SizeUtils.width - 100.h,
                      child: Text(
                        '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),

              /// Product Detail,
              SizedBox(height: 24.v),
              Text('Item Details', style: textTheme.titleMedium),
              SizedBox(height: 8.v),
              _buildCartItem(
                  CartModel(
                      cartId: 1,
                      id: 1,
                      url: imagesList[6],
                      price: 120,
                      quantity: 1,
                      name: 'Name',
                      isSelected: true),
                  context),

              /// Apply Coupon
              SizedBox(height: 24.v),
              Text('Available Coupon', style: textTheme.titleMedium),
              SizedBox(height: 12.v),
              CustomTextFormField(
                  hintText: 'Coupon code',
                  suffix: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: textTheme.bodySmall!.copyWith(
                          fontSize: 15.h, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(height: 24.v),
              Text('Payment Details', style: textTheme.titleMedium),
              SizedBox(height: 12.v),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.offWhite,
                    borderRadius: BorderRadius.circular(5.h)),
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    _buildDetailsTile(context, title: "Item", value: "1"),
                    _buildDetailsTile(context,
                        title: "Delivery:", value: "free"),
                    _buildDetailsTile(context, title: "Total:", value: "₹150"),
                    _buildDetailsTile(context,
                        title: "Coupon Code", value: "₹30"),
                    const Divider(),
                    _buildDetailsTile(context,
                        title: "Order Total:", value: "₹50"),
                  ],
                ),
              ),
              SizedBox(height: 24.v),

              ///Select Payment Method
              // Text(
              //   'Select Payment Method',
              //   style: textTheme.titleMedium,
              // ),
              // SizedBox(height: 12.v),
              // Row(
              //   children: [
              //     Expanded(
              //         child: CustomOutlineButton(
              //             buttonStyle: OutlinedButton.styleFrom(
              //                 elevation: 0,
              //                 backgroundColor: Colors.white,
              //                 shape: const StadiumBorder()),
              //             text: 'COD')),
              //     const Expanded(
              //         child: CustomOutlineButton(text: 'Online payment')),
              //   ],
              // )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total', style: textTheme.bodySmall),
                SizedBox(height: 5.v),
                Text('₹120',
                    style: textTheme.titleLarge!.copyWith(fontSize: 20.fSize)),
              ],
            ),
            CustomElevatedButton(
              width: 160.h,
              height: 48.v,
              text: 'Pay Now',
              buttonTextStyle: TextStyle(fontSize: 14.fSize),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildDetailsTile(BuildContext context,
      {required String title, required String value}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.bodySmall),
          Text(value, style: textTheme.titleMedium),
        ],
      ),
    );
  }

  InkWell _buildCartItem(CartModel item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.productDetailScreen, arguments: item.id);
      },
      child: SizedBox(
        width: SizeUtils.width,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.v),
          child: Row(
            children: [
              CustomImageView(
                width: 75.h,
                height: 75.v,
                fit: BoxFit.fill,
                radius: BorderRadius.only(
                    topLeft: Radius.circular(12.h),
                    bottomLeft: Radius.circular(12.h)),
                imagePath: item.url,
              ),
              SizedBox(width: 5.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.bodySmall,
                    ),
                    SizedBox(height: 8.v),
                    Row(
                      children: [
                        Text(
                          '₹${item.price}',
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(width: 15.h),
                        // Text(
                        //   '₹${item.}',
                        //   style: textTheme.titleMedium,
                        // ),
                      ],
                    ),
                    SizedBox(height: 12.v),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
