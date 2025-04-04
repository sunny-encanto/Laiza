// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:laiza/data/models/coupon_detail_model/coupon_detail_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';
import 'package:laiza/data/repositories/coupon_repository/coupon_repository.dart';
import 'package:laiza/presentation/order_summary/cubit/order_summary_cubit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../data/models/address_model/address_model.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../../data/repositories/order_repository/order_repository.dart';
import '../../../data/services/razorpay_service.dart';
import '../../address_screen/bloc/address_bloc.dart';

class OrderSummary extends StatefulWidget {
  final List<CartModel> items;

  const OrderSummary({super.key, required this.items});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final TextEditingController couponController = TextEditingController();

  num couponPrice = 0;
  num totalPrice = 0;
  num afterDiscountTotal = 0;
  Address? address;
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService(
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
  }

  @override
  void dispose() {
    _razorpayService.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.showSnackBar("Payment Successful: ${response.paymentId}");
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.orderPlacedScreen, (route) => false);
    context
        .read<OrderRepository>()
        .crateOrder(widget.items, PaymentMode.ONLINE.name);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    context.showSnackBar("Payment Failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    context.showSnackBar("External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    totalPrice = widget.items
        .fold(0.0, (total, item) => total + (item.price * item.quantity));

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
                      address = state.address;
                      return state.address.addressType != null
                          ? Container(
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
                                        borderRadius:
                                            BorderRadius.circular(12.h)),
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
                                                Navigator.of(context)
                                                    .pushNamed(
                                                        AppRoutes
                                                            .addAddressScreen,
                                                        arguments:
                                                            state.address)
                                                    .then((_) => context
                                                        .read<AddressBloc>()
                                                        .add(
                                                            FetchDefaultAddressEvent()));
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
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.addressScreen)
                                    .then(
                                  (_) {
                                    context
                                        .read<AddressBloc>()
                                        .add(FetchDefaultAddressEvent());
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24.h,
                                    height: 24.v,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.h),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: const Text('+'),
                                  ),
                                  SizedBox(width: 12.h),
                                  Text(
                                    'Add new address',
                                    style: textTheme.titleMedium,
                                  )
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
                  widget.items.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.v),
                    child: _buildCartItem(
                        CartModel(
                          inventoryId: widget.items[index].inventoryId,
                          cartId: widget.items[index].cartId,
                          id: widget.items[index].id,
                          url: widget.items[index].url,
                          price: widget.items[index].price,
                          quantity: widget.items[index].quantity,
                          name: widget.items[index].name,
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
              BlocConsumer<OrderSummaryCubit, OrderSummaryState>(
                listener: (context, state) {
                  if (state is DiscountAdded) {
                    afterDiscountTotal = state.totalPrice;
                    couponPrice = state.discountPrice;
                  }
                },
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColor.offWhite,
                        borderRadius: BorderRadius.circular(5.h)),
                    padding: EdgeInsets.all(20.h),
                    child: Column(
                      children: [
                        _buildDetailsTile(context,
                            title: "Item",
                            value: widget.items.length.toString()),
                        _buildDetailsTile(context,
                            title: "Delivery:", value: "free"),
                        _buildDetailsTile(context,
                            title: "Total:",
                            value: "₹${totalPrice.toStringAsFixed(2)}"),
                        _buildDetailsTile(context,
                            title: "Coupon price:", value: "₹$couponPrice"),
                        const Divider(),
                        _buildDetailsTile(context,
                            title: "Order Total:",
                            value:
                                "₹${(totalPrice - couponPrice).toStringAsFixed(2)}"),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10.v),
              CustomOutlineButton(
                onPressed: () async {
                  if (address?.city == null) {
                    context.showSnackBar('Please add address');
                    return;
                  } else {
                    try {
                      await context
                          .read<OrderRepository>()
                          .crateOrder(widget.items, PaymentMode.COD.name);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.orderPlacedScreen, (route) => false);
                    } catch (e) {
                      context.showSnackBar(e.toString());
                    }
                  }
                },
                buttonStyle: OutlinedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(
                        side: BorderSide(color: AppColor.primary))),
                text: 'COD',
              ),
              SizedBox(height: 80.v),

              ///Select Payment Method
              // Text(
              //   'Select Payment Method',
              //   style: textTheme.titleMedium,
              // ),
              // SizedBox(height: 12.v),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<OrderSummaryCubit, OrderSummaryState>(
              listener: (context, state) {
                // if (state is DiscountAdded) {
                //   totalPrice = state.totalPrice;
                //   couponPrice = state.discountPrice;
                // }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total', style: textTheme.bodySmall),
                    SizedBox(height: 5.v),
                    Text('₹${(totalPrice - couponPrice).toStringAsFixed(2)}',
                        style:
                            textTheme.titleLarge!.copyWith(fontSize: 20.fSize)),
                  ],
                );
              },
            ),
            CustomElevatedButton(
                width: 160.h,
                height: 48.v,
                text: 'Pay Now',
                buttonTextStyle: TextStyle(fontSize: 14.fSize),
                onPressed: _startPayment
                //     () {
                //   // Navigator.of(context).pushNamed(AppRoutes.orderPlacedScreen);
                //   // context.read<OrderRepository>().crateOrder(items);
                // },
                ),
          ],
        ),
      ),
    );
  }

  void _startPayment() {
    if (address?.city == null) {
      context.showSnackBar('Please add address');
      return;
    } else {
      _razorpayService.openCheckout(
        amount: (totalPrice - couponPrice).toInt(),
        name: 'Laiza',
        description: 'Payment for Product',
        contact: '9876543210',
        email: 'test@example.com',
      );
    }
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
  void _showCouponBottomSheet(BuildContext previousContext, totalPrice) {
    showModalBottomSheet(
      context: previousContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext _) {
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
                        "Get ${couponDetail.amount} ${(couponDetail.type == 'percent') ? '%' : 2} off",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      // Expiry date
                      // const Text(
                      //   "Valid until March 15, 2025",
                      //   style: TextStyle(fontSize: 14, color: Colors.grey),
                      // ),
                      const Spacer(),
                      // Apply button
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: () {
                            previousContext
                                .read<OrderSummaryCubit>()
                                .applyCoupon(couponDetail, totalPrice);
                            Navigator.pop(context);
                            context
                                .showSnackBar("Coupon applied successfully!");

                            // totalPrice = _getPriceAfterDiscount(
                            //   totalPrice,
                            //   couponDetail.amount.toDouble(),
                            //
                            // );
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
