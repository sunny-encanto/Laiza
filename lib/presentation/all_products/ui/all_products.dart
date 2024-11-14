import 'package:laiza/core/app_export.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'All Products',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          )),
      body: GridView.builder(
          shrinkWrap: true,
          itemCount: imagesList.length,
          padding: EdgeInsets.all(20.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 168.h / 317.v,
            crossAxisCount: 2,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 10.v,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildProductCart(textTheme);
          }),
    );
  }

  Container _buildProductCart(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.offWhite, borderRadius: BorderRadius.circular(12.h)),
      width: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 185.v,
            radius: BorderRadius.circular(12.h),
            imagePath: ImageConstant.productImage,
          ),
          SizedBox(height: 4.v),
          Text(
            'Classic White Sneakers',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          Text(
            'by Shubham Deep',
            style: textTheme.bodySmall,
          ),
          SizedBox(height: 4.v),
          Row(
            children: [
              Text(
                'Category- ',
                style: textTheme.bodySmall,
              ),
              Text(
                'Footwear',
                style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
              ),
            ],
          ),
          SizedBox(height: 4.v),
          Row(
            children: [
              Text(
                'Promotion Pricing- ',
                style: textTheme.bodySmall,
              ),
              Expanded(
                child: Text(
                  '₹4K-8K',
                  style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.v),
          Center(
            child: CustomElevatedButton(
              height: 26.v,
              text: 'Ask for Promotion',
              buttonTextStyle: textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
