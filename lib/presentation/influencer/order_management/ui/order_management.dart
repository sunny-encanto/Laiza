import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../bloc/influencer_orders_bloc.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 46.v,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 12.h),
                    child: index == 0
                        ? Chip(
                            backgroundColor: AppColor.primary,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.menuIcon,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5.h),
                                Text(
                                  'Filters',
                                  style: textTheme.bodySmall!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ))
                        : Chip(
                            shape: StadiumBorder(
                                side: BorderSide(color: AppColor.primary)),
                            backgroundColor: Colors.white,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  getFilterName(index),
                                  style: textTheme.bodySmall!
                                      .copyWith(color: AppColor.primary),
                                ),
                              ],
                            )),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Upcoming Orders',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              BlocBuilder<InfluencerOrdersBloc, InfluencerOrdersState>(
                builder: (context, state) {
                  if (state is InfluencerOrdersInitial) {
                    context
                        .read<InfluencerOrdersBloc>()
                        .add(FetchInfluencerOrdersEvent());
                  } else if (state is InfluencerOrdersLoading) {
                    return const LoadingListPage();
                  } else if (state is InfluencerOrdersLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildItem(textTheme, context);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Text(
                'Received  Orders',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildItem(textTheme, context, OrderStatus.Received);
                },
              ),
              Text(
                'Returned Order',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildItem(textTheme, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFilterName(int index) {
    switch (index) {
      case 1:
        return 'All';
      case 2:
        return 'Upcoming Orders';
      case 3:
        return 'Received Orders';
      default:
        return '';
    }
  }

  SizedBox _buildItem(TextTheme textTheme, BuildContext context,
      [OrderStatus orderStatus = OrderStatus.Upcoming]) {
    return SizedBox(
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
              imagePath:
                  'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Classic  Sneakers – Minimalist Design, Maximum Comfort',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 3.v),
                  Text(
                    'by Shubham Deep',
                    style: textTheme.bodySmall,
                  ),
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
                  orderStatus == OrderStatus.Received
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Delivery- ',
                                  style: textTheme.bodySmall,
                                ),
                                SizedBox(width: 5.v),
                                Text(
                                  'Thu, 19 oct',
                                  style: textTheme.bodySmall!
                                      .copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Days left- ',
                                  style: textTheme.bodySmall,
                                ),
                                SizedBox(width: 5.v),
                                Text(
                                  '3 days',
                                  style: textTheme.bodySmall!
                                      .copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              'Estimated date- ',
                              style: textTheme.bodySmall,
                            ),
                            SizedBox(width: 5.v),
                            Text(
                              'Tue, 17 oct',
                              style: textTheme.bodySmall!
                                  .copyWith(color: AppColor.primary),
                            ),
                          ],
                        ),
                  SizedBox(height: 12.v),
                  orderStatus == OrderStatus.Received
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.returnProductScreen);
                            },
                            child: Text(
                              'Return Product',
                              style: textTheme.bodySmall!.copyWith(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.orderTrackScreen);
                            },
                            child: Text(
                              'Track Order',
                              style: textTheme.bodySmall!.copyWith(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
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

enum OrderStatus { Upcoming, Received, Returned }
