import '../core/app_export.dart';

class StreamsCard extends StatelessWidget {
  const StreamsCard({super.key, this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8.h),
      width: width ?? 185.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h), color: AppColor.offWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5.h),
                height: 100.v,
                width: 100.v,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                    color: AppColor.offWhite),
                child: CustomImageView(
                  height: 90.h,
                  width: 90.v,
                  fit: BoxFit.fill,
                  radius: BorderRadius.circular(200.h),
                  imagePath:
                      'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
                ),
              ),
              Positioned(
                top: 5.v,
                right: -30.h,
                child: Row(
                  children: [
                    Container(
                      height: 8.v,
                      width: 8.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    SizedBox(width: 2.h),
                    Text(
                      'LIVE',
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Kiara Kapoor',
            style: textTheme.titleLarge!.copyWith(fontSize: 16.fSize),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.visibilityIcon, color: Colors.grey),
              SizedBox(width: 5.h),
              Text(
                '1.2K viewers',
                style: textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: CustomElevatedButton(
              height: 33.v,
              width: 122.h,
              text: 'Watch Now',
              onPressed: () {},
              buttonTextStyle: textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
