import 'package:laiza/core/app_export.dart';

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
              Text(
                'Upcoming Orders',
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
