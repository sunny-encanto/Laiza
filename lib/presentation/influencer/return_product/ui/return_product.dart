import 'package:laiza/core/app_export.dart';

class ReturnProductScreen extends StatelessWidget {
  const ReturnProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Return Product',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(textTheme),
            const Divider(height: 0.2),
            SizedBox(height: 28.v),
            Text(
              'Have you uploaded the reel',
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 8.v),
            CustomTextFormField(hintText: 'Paste URL'),
            SizedBox(height: 24.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: AppColor.primary,
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  'Have you promoted it on live stream',
                  style: textTheme.bodyMedium,
                )
              ],
            ),
            SizedBox(height: 40.v),
            Text('Deliver to', style: textTheme.titleMedium),
            SizedBox(height: 12.v),
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
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: const CustomElevatedButton(text: 'Confirm'),
      ),
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
