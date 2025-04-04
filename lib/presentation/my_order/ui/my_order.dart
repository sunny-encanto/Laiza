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
                List<OrderItem> orderList = <OrderItem>[];
                orderList.clear();
                for (var item in state.myOrdersModel.orders) {
                  orderList.addAll(item.items);
                }
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildItem(orderList[index], context);
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Past Orders',
                    //       style: textTheme.titleMedium,
                    //     ),
                    //     Text('View All', style: textTheme.bodySmall)
                    //   ],
                    // ),
                    // SizedBox(height: 20.h),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: 3,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     return _buildItem(textTheme, context);
                    //   },
                    // ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
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
                // Navigator.of(context).pushNamed(AppRoutes.orderTrackScreen);
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
                  Row(
                    children: [
                      Text(
                        'Status-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        'Shipped',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
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
