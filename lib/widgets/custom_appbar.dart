import 'package:laiza/core/app_export.dart';

PreferredSize customAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(SizeUtils.width, 60.h),
    child: AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      toolbarHeight: 50.h,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32.h),
        bottomRight: Radius.circular(32.h),
      )),
      backgroundColor: const Color(0xFFF9F9F9),
      title: CustomImageView(
        width: 98.h,
        imagePath: ImageConstant.logo,
      ),
      actions: [
        CustomIconButton(
          icon: ImageConstant.searchIcon,
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.searchScreen);
          },
        ),
        SizedBox(width: 16.h),
        CustomIconButton(
          icon: ImageConstant.cartIcon,
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.cartScreen);
          },
        ),
        SizedBox(width: 16.h),
      ],
    ),
  );
}
