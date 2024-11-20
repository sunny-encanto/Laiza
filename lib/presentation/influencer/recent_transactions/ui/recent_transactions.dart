import '../../../../core/app_export.dart';

class RecentTransactionsScreen extends StatelessWidget {
  const RecentTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Transactions',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              SizedBox(
                height: 46.v,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: _buildFilterWidget(index, textTheme)),
                ),
              ),
              SizedBox(height: 24.v),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
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

  Widget _buildFilterWidget(int index, textTheme) {
    switch (index) {
      case 0:
        return Chip(
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
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                )
              ],
            ));

      case 1:
        return Chip(
            shape: StadiumBorder(side: BorderSide(color: AppColor.primary)),
            backgroundColor: Colors.white,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment Status',
                  style: textTheme.bodySmall!.copyWith(color: AppColor.primary),
                ),
                SizedBox(width: 5.h),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.primary,
                )
              ],
            ));

      case 2:
        return Chip(
            shape: StadiumBorder(side: BorderSide(color: AppColor.primary)),
            backgroundColor: Colors.white,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Month',
                  style: textTheme.bodySmall!.copyWith(color: AppColor.primary),
                ),
                SizedBox(width: 5.h),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.primary,
                )
              ],
            ));

      default:
        return const SizedBox();
    }
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
                    'Latest Western Wear A-Line Multicolor One Piece Dress For Women',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  Row(
                    children: [
                      Text(
                        'Deal Amount-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        '₹8000',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                  Row(
                    children: [
                      Text(
                        'Payment Status-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        'Completed',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.greenColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                  Row(
                    children: [
                      Text(
                        'Seller-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        'Devendra Soni',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
