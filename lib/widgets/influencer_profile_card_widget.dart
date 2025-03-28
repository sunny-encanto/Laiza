import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/all_influencer_bloc/bloc/all_influencer_bloc.dart';
import 'package:laiza/data/models/user/user_model.dart';

class InfluencerProfileCardWidget extends StatelessWidget {
  final UserModel userModel;

  const InfluencerProfileCardWidget({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
            arguments: userModel.id);
      },
      child: Container(
        width: 185.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            color: AppColor.offWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 11.h),
            Container(
              padding: EdgeInsets.all(5.h),
              height: 100.v,
              width: 100.v,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  color: AppColor.offWhite),
              child: CustomImageView(
                height: 100.v,
                width: 100.v,
                fit: BoxFit.fill,
                radius: BorderRadius.circular(200.h),
                imagePath: userModel.profileImg,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              userModel.name ?? '',
              style: textTheme.titleLarge!.copyWith(
                  fontSize: 16.fSize, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                    imagePath: ImageConstant.groupIcon, color: Colors.grey),
                SizedBox(width: 5.h),
                Text(
                  '${userModel.followersCount} Followers',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(
            //     3,
            //     (index) => CustomImageView(
            //       margin: EdgeInsets.only(right: 3.h),
            //       height: 50.h,
            //       width: 50.v,
            //       radius: BorderRadius.circular(6.h),
            //       fit: BoxFit.fill,
            //       imagePath:
            //           'https://farm9.staticflickr.com/8295/8007075227_dc958c1fe6_z_d.jpg',
            //     ),
            //   ),
            // ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomElevatedButton(
                height: 33.v,
                width: 122.h,
                text: (userModel.isFollowed ?? false)
                    ? 'Following'
                    : 'Follow Now',
                buttonTextStyle: textTheme.titleSmall,
                onPressed: () {
                  context
                      .read<AllInfluencerBloc>()
                      .add(MakeFollowRequestEvent(userModel.id ?? ''));
                },
              ),
            ),
            SizedBox(height: 8.h),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
            //         arguments: userModel.id);
            //   },
            //   child: Text(
            //     'View Profile',
            //     style: textTheme.bodySmall!
            //         .copyWith(decoration: TextDecoration.underline),
            //   ),
            // ),
            // SizedBox(height: 13.h),
          ],
        ),
      ),
    );
  }
}
