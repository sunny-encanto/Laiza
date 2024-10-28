import 'package:laiza/core/app_export.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomImageView(
            width: SizeUtils.width,
            height: 302.v,
            imagePath: ImageConstant.orderPlaced,
          ),
          Text(
            'Order Placed!',
            style: textTheme.titleLarge,
          ),
          SizedBox(height: 12.v),
          SizedBox(
            width: 279.h,
            child: Text(
              'Your order has been successfully processed  and is on its way to you soon.',
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.v),
          CustomElevatedButton(
            width: SizeUtils.width - 36.h,
            text: 'Order Details',
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.orderTrackScreen);
            },
          ),
          SizedBox(height: 20.v),
          CustomOutlineButton(
            width: SizeUtils.width - 36.h,
            text: 'Continue Shopping',
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
