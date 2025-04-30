import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/my_orders_model/my_order_model.dart';
import 'package:laiza/presentation/my_order/bloc/my_order_bloc.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Orders',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              if (state is MyOrderInitial) {
                context.read<MyOrderBloc>().add(FetchMyOrders());
              } else if (state is MyOrderError) {
                return Center(child: Text(state.message));
              } else if (state is MyOrderLoaded) {
                if (state.myOrdersModel.orders.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 120.v,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CustomImageView(
                          imagePath: ImageConstant.noOrders,
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.myOrdersModel.orders.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.orderTrackScreen, arguments: {
                          "trackingId":
                              state.myOrdersModel.orders[index].trackingId ??
                                  '',
                          'orderId':
                              state.myOrdersModel.orders[index].id.toString()
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => SeeOrderItem(
                        //       orders: state.myOrdersModel.orders[index]),
                        // ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.v),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                              color: AppColor.primary.withOpacity(0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Order #${state.myOrdersModel.orders[index].orderNumber}',
                                    style: textTheme.titleMedium),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: state.myOrdersModel.orders[index]
                                                .status ==
                                            'Completed'
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    state.myOrdersModel.orders[index].status,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: state.myOrdersModel.orders[index]
                                                  .status ==
                                              'Completed'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Price: ₹${state.myOrdersModel.orders[index].finalPrice}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Payment Mode: ${state.myOrdersModel.orders[index].paymentStatus}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Icon(Icons.shopping_basket_outlined,
                                    color: AppColor.primary),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${state.myOrdersModel.orders[index].items.length} Items',
                                  style: textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class SeeOrderItem extends StatelessWidget {
  final Order orders;

  const SeeOrderItem({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'My Orders',
            style: textTheme.titleMedium,
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildItem(orders.items[index], context);
            }));
  }

  SizedBox _buildItem(OrderItem item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: SizeUtils.width,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.v),
        child: Row(
          children: [
            CustomImageView(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.orderTrackScreen,
                    arguments: {
                      "trackingId": item.trackingId,
                      'orderId': item.orderId.toString()
                    });
              },
              width: 135.h,
              height: 135.v,
              fit: BoxFit.fill,
              radius: BorderRadius.only(
                  topLeft: Radius.circular(12.h),
                  bottomLeft: Radius.circular(12.h)),
              imagePath: item.product.productImage,
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.productName,
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Status-',
                  //       style: textTheme.bodySmall,
                  //     ),
                  //     SizedBox(width: 5.v),
                  //     Text(
                  //       item.product.,
                  //       style: textTheme.bodySmall!
                  //           .copyWith(color: AppColor.primary),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 8.v),
                  Text(
                    '₹${item.price}',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.addRatingScreen,
                          arguments: item.product.id);
                    },
                    child: Text(
                      'Rate Order',
                      style: textTheme.bodySmall!.copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
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
}
