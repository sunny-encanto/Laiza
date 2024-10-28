import 'package:laiza/core/app_export.dart';

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
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildItem(textTheme, context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Past Orders',
                    style: textTheme.titleMedium,
                  ),
                  Text('View All', style: textTheme.bodySmall)
                ],
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

  SizedBox _buildItem(TextTheme textTheme, BuildContext context) {
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
                    '₹ 2,799',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  InkWell(
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
