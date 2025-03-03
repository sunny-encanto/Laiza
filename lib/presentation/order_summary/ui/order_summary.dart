// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:laiza/data/models/coupon_detail_model/coupon_detail_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';
import 'package:laiza/data/repositories/coupon_repository/coupon_repository.dart';

import '../../../data/models/cart_model/cart_model.dart';
import '../../../data/repositories/order_repository/order_repository.dart';
import '../../address_screen/bloc/address_bloc.dart';

class OrderSummary extends StatelessWidget {
  final List<CartModel> items;

  OrderSummary({super.key, required this.items});

  final TextEditingController couponController = TextEditingController();
  int couponPrice = 30;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final totalPrice =
        items.fold(0.0, (total, item) => total + (item.price * item.quantity));

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
              BlocProvider(
                create: (context) =>
                    AddressBloc(context.read<AddressRepository>()),
                child: BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    if (state is AddressInitial) {
                      context
                          .read<AddressBloc>()
                          .add(FetchDefaultAddressEvent());
                    } else if (state is AddressLoading) {
                      return const SizedBox.shrink();
                    } else if (state is AddressError) {
                      return Center(child: Text(state.message));
                    } else if (state is DefaultAddressLoaded) {
                      return Container(
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
                              child: Text(
                                state.address.addressType ?? '',
                                style: textTheme.titleSmall!
                                    .copyWith(color: Colors.black),
                              ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping Address',
                                        style: textTheme.titleMedium,
                                      ),
                                      CustomImageView(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              AppRoutes.addAddressScreen);
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
                                '${state.address.houseNo}, ${state.address.areaStreet},${state.address.landmark},${state.address.city},${state.address.state},${state.address.pinCode}',
                                style: textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              /// Address Box

              /// Product Detail,
              SizedBox(height: 24.v),
              Text('Item Details', style: textTheme.titleMedium),
              SizedBox(height: 8.v),
              Column(
                children: List.generate(
                  items.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.v),
                    child: _buildCartItem(
                        CartModel(
                          cartId: items[index].cartId,
                          id: items[index].id,
                          url: items[index].url,
                          price: items[index].price,
                          quantity: 1,
                          name: items[index].name,
                          isSelected: true,
                        ),
                        context),
                  ),
                ),
              ),

              /// Apply Coupon
              SizedBox(height: 24.v),
              Text('Available Coupon', style: textTheme.titleMedium),
              SizedBox(height: 12.v),
              CustomTextFormField(
                  controller: couponController,
                  hintText: 'Coupon code',
                  suffix: TextButton(
                    onPressed: () =>
                        _showCouponBottomSheet(context, totalPrice),
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
                    _buildDetailsTile(context,
                        title: "Item", value: items.length.toString()),
                    _buildDetailsTile(context,
                        title: "Delivery:", value: "free"),
                    _buildDetailsTile(context,
                        title: "Total:", value: "₹$totalPrice"),
                    _buildDetailsTile(context,
                        title: "Coupon Code", value: "₹$couponPrice"),
                    const Divider(),
                    _buildDetailsTile(context,
                        title: "Order Total:",
                        value: "₹${totalPrice - couponPrice}"),
                  ],
                ),
              ),
              SizedBox(height: 80.v),

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total', style: textTheme.bodySmall),
                SizedBox(height: 5.v),
                Text('₹${totalPrice - couponPrice}',
                    style: textTheme.titleLarge!.copyWith(fontSize: 20.fSize)),
              ],
            ),
            CustomElevatedButton(
              width: 160.h,
              height: 48.v,
              text: 'Pay Now',
              buttonTextStyle: TextStyle(fontSize: 14.fSize),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.orderPlacedScreen);
                context.read<OrderRepository>().crateOrder(items);
              },
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
            SizedBox(width: 10.h),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${item.price}',
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(width: 15.h),
                      Text(
                        item.quantity.toString(),
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to show the bottom sheet
  void _showCouponBottomSheet(BuildContext context, totalPrice) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CouponBloc(context.read<CouponRepository>()),
          child: BlocConsumer<CouponBloc, CouponState>(
            listener: (context, state) {
              if (state is CouponError) {
                context.showSnackBar(state.message);
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
              }
            },
            builder: (context, state) {
              if (state is CouponInitial) {
                context
                    .read<CouponBloc>()
                    .add(FetchCouponDetailsEvent(couponController.text));
              } else if (state is CouponLoading) {
                return const SizedBox.shrink();
              } else if (state is CouponLoaded) {
                CouponDetail couponDetail = state.couponDetail;
                return Container(
                  padding: const EdgeInsets.all(16),
                  height: 250.v, // Adjust height as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close button
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      // Coupon title
                      const Text(
                        "Coupon Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Coupon code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Code: ${couponDetail.title}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.green),
                          ),
                          const Icon(Icons.copy, size: 20, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Discount details
                      Text(
                        "Get ${couponDetail.amount} off on orders above \$50",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      // Expiry date
                      const Text(
                        "Valid until March 15, 2025",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(),
                      // Apply button
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () {
                            totalPrice = totalPrice - couponDetail.amount;
                            // Add your apply coupon logic here
                            Navigator.pop(context); // Close the bottom sheet
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Coupon applied successfully!")),
                            );
                          },
                          text: "Apply Coupon",
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
