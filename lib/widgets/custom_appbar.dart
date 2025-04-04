import 'package:laiza/core/app_export.dart';

import '../presentation/profile/bloc/profile_bloc.dart';

PreferredSize customAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(SizeUtils.width, 60.h),
    child: AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
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
        Stack(
          alignment: Alignment.topRight,
          children: [
            CustomIconButton(
              icon: ImageConstant.cartIcon,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              },
            ),
            BlocProvider(
              create: (context) => ProfileBloc(context.read<UserRepository>()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileInitial) {
                    context.read<ProfileBloc>().add(FetchProfile());
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  } else if (state is ProfileLoaded) {
                    return Container(
                      padding: EdgeInsets.all(3.h),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.primary),
                      child: Text(state.userModel.cartCount.toString()),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        SizedBox(width: 16.h),
      ],
    ),
  );
}
