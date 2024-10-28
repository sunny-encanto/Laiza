import 'package:laiza/core/app_export.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

class OrderTrackScreen extends StatelessWidget {
  const OrderTrackScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItem(textTheme),
              const Divider(),
              SizedBox(height: 16.v),
              Column(
                children: [
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.locationIcon,
                      ),
                      SizedBox(width: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 4.v),
                          SizedBox(
                            width: SizeUtils.width - 80.h,
                            child: Text(
                              '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
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
                        imagePath: ImageConstant.shippingIcon,
                      ),
                      SizedBox(width: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(height: 4.v),
                          SizedBox(
                            width: SizeUtils.width - 100.h,
                            child: Text(
                              '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: 32.v),
              Text(
                'Order Status',
                style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
              ),
              SizedBox(height: 12.v),
              _buildOrderTrackWidget(),
              SizedBox(height: 100.v),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: const CustomOutlineButton(text: 'Cancel Order'),
      ),
    );
  }

  OrderTrackerZen _buildOrderTrackWidget() {
    return OrderTrackerZen(
      success_color: AppColor.primary,
      tracker_data: [
        TrackerData(
          title: "Order Place",
          date: "Sat, 8 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Your order was placed on Zenzzen",
              datetime: "Sat, 8 Apr '22 - 17:17",
            ),
            TrackerDetails(
              title: "Zenzzen Arranged A Callback Request",
              datetime: "Sat, 8 Apr '22 - 17:42",
            ),
          ],
        ),
        TrackerData(
          title: "Order Shipped",
          date: "Sat, 8 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Your order was shipped with MailDeli",
              datetime: "Sat, 8 Apr '22 - 17:50",
            ),
          ],
        ),
        TrackerData(
          title: "Order Delivered",
          date: "Sat,8 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "You received your order, by MailDeli",
              datetime: "Sat, 8 Apr '22 - 17:51",
            ),
          ],
        ),
      ],
    );
  }

  SizedBox _buildItem(TextTheme textTheme) {
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
                  SizedBox(height: 8.v),
                  Text(
                    'White Color, Size-8,100% Premium Leather Upper',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 4.v),
                  Text(
                    'Order ID- 14502426',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    '₹ 2,799',
                    style: textTheme.titleMedium,
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
