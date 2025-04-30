import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/date_time_utils.dart';
import 'package:laiza/presentation/order_track/cubit/order_track_cubit.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

import '../../../data/models/tracking_model/tracking_model.dart';

class OrderTrackScreen extends StatelessWidget {
  final String trackingId;
  final String orderId;

  const OrderTrackScreen(
      {super.key, required this.trackingId, required this.orderId});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tracking Details',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocBuilder<OrderTrackCubit, OrderTrackState>(
        buildWhen: (previous, current) => (current is OrderTrackLoading ||
            current is OrderTrackError ||
            current is OrderTrackLoaded),
        builder: (context, state) {
          if (state is OrderTrackInitial) {
            context.read<OrderTrackCubit>().onFetchTrackingDetails(trackingId);
          } else if (state is OrderTrackLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderTrackError) {
            return Center(child: Text(state.message));
          } else if (state is OrderTrackLoaded) {
            context.read<OrderTrackCubit>().onFetchOrderDetails(orderId);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItem(textTheme),
                    // const Divider(),
                    // SizedBox(height: 16.v),
                    // Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         CustomImageView(
                    //           imagePath: ImageConstant.locationIcon,
                    //         ),
                    //         SizedBox(width: 8.h),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'From',
                    //               style: textTheme.bodySmall,
                    //             ),
                    //             SizedBox(height: 4.v),
                    //             SizedBox(
                    //               width: SizeUtils.width - 80.h,
                    //               child: Text(
                    //                 '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
                    //                 style: textTheme.titleMedium,
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //     SizedBox(height: 12.v),
                    //     Row(
                    //       children: [
                    //         CustomImageView(
                    //           imagePath: ImageConstant.shippingIcon,
                    //         ),
                    //         SizedBox(width: 8.h),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               'To',
                    //               style: textTheme.bodySmall,
                    //             ),
                    //             SizedBox(height: 4.v),
                    //             SizedBox(
                    //               width: SizeUtils.width - 100.h,
                    //               child: Text(
                    //                 '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
                    //                 style: textTheme.titleMedium,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //
                    const Divider(),
                    SizedBox(height: 32.v),
                    Text(
                      'Order Status',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    SizedBox(height: 12.v),
                    _buildOrderTrackWidget(state.trackingDetailModel
                        .trackingDetailList[0].statusLogList),
                    SizedBox(height: 100.v),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: const CustomOutlineButton(text: 'Cancel Order'),
      ),
    );
  }

  OrderTrackerZen _buildOrderTrackWidget(List<StatusLogList> statusLogList) {
    return OrderTrackerZen(
        success_color: AppColor.primary,
        tracker_data: List.generate(
          statusLogList.length,
          (index) => TrackerData(
            title: statusLogList[index].status,
            date: statusLogList[index].dateTime.format(),
            tracker_details: [
              // TrackerDetails(
              //   title: statusLogList[index].status,
              //   datetime: "Sat, 8 Apr '22 - 17:17",
              // ),
              // TrackerDetails(
              //   title: "Zenzzen Arranged A Callback Request",
              //   datetime: "Sat, 8 Apr '22 - 17:42",
              // ),
            ],
          ),
        )
        // [
        //   TrackerData(
        //     title: "Order Place",
        //     date: "Sat, 8 Apr '22",
        //     tracker_details: [
        //       TrackerDetails(
        //         title: "Your order was placed on Zenzzen",
        //         datetime: "Sat, 8 Apr '22 - 17:17",
        //       ),
        //       TrackerDetails(
        //         title: "Zenzzen Arranged A Callback Request",
        //         datetime: "Sat, 8 Apr '22 - 17:42",
        //       ),
        //     ],
        //   ),
        //   TrackerData(
        //     title: "Order Shipped",
        //     date: "Sat, 8 Apr '22",
        //     tracker_details: [
        //       TrackerDetails(
        //         title: "Your order was shipped with MailDeli",
        //         datetime: "Sat, 8 Apr '22 - 17:50",
        //       ),
        //     ],
        //   ),
        //   TrackerData(
        //     title: "Order Delivered",
        //     date: "Sat,8 Apr '22",
        //     tracker_details: [
        //       TrackerDetails(
        //         title: "You received your order, by MailDeli",
        //         datetime: "Sat, 8 Apr '22 - 17:51",
        //       ),
        //     ],
        //   ),
        // ],
        );
  }

  _buildItem(TextTheme textTheme) {
    return BlocBuilder<OrderTrackCubit, OrderTrackState>(
      buildWhen: (previous, current) => current is SingleOrderDetailsLoaded,
      builder: (context, state) {
        if (state is OrderTrackLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrderTrackError) {
          return Center(child: Text(state.message));
        } else if (state is SingleOrderDetailsLoaded) {
          return Column(
              children: List.generate(
                  state.trackingDetailModel.data.items.length,
                  (index) => SizedBox(
                        width: SizeUtils.width,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.v),
                          child: Row(
                            children: [
                              CustomImageView(
                                width: 135.h,
                                height: 135.v,
                                fit: BoxFit.fill,
                                radius: BorderRadius.only(
                                    topLeft: Radius.circular(12.h),
                                    bottomLeft: Radius.circular(12.h)),
                                imagePath: state.trackingDetailModel.data
                                    .items[index].product.productImage,
                              ),
                              SizedBox(width: 5.h),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.trackingDetailModel.data
                                          .items[index].product.productName,
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 8.v),
                                    Text(
                                      'Order ID- 14502426',
                                      style: textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 8.v),
                                    Text(
                                      '₹ ${state.trackingDetailModel.data.items[index].product.finalPrice}',
                                      style: textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 12.v),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
