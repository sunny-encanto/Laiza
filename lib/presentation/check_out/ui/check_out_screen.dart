import 'package:laiza/core/app_export.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppColor.offWhite,
        title: Text(
          'Delivery Address',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(height: 29.v),
            Container(
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home_outlined,
                            color: Colors.black45,
                          ),
                          Text(
                            'Home',
                            style: textTheme.titleSmall!
                                .copyWith(color: Colors.black),
                          )
                        ]),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Address',
                              style: textTheme.titleMedium,
                            ),
                            CustomImageView(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.addAddressScreen);
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
                      '123 Elmwood Street, Apt 4B Springfield, IL 62701, United States',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.v),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addAddressScreen);
              },
              child: Row(
                children: [
                  Container(
                    width: 24.h,
                    height: 24.v,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.h),
                        border: Border.all(color: Colors.black)),
                    child: const Text('+'),
                  ),
                  SizedBox(width: 12.h),
                  Text(
                    'Add new address',
                    style: textTheme.titleMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: textTheme.bodySmall,
                ),
                Text(
                  '₹ 2,799',
                  style: textTheme.titleMedium,
                )
              ],
            ),
            CustomElevatedButton(
                width: 160.h,
                leftIcon: CustomImageView(
                  imagePath: ImageConstant.checkOut,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.orderPlacedScreen);
                },
                text: 'Pay Now'),
          ],
        ),
      ),
    );
  }
}
