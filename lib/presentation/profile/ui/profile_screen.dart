import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/services/firebase_services.dart';
import 'package:laiza/presentation/profile/bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileBloc(context.read<UserRepository>()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(FetchProfile());
            } else if (state is ProfileInitial) {
              return const SizedBox.shrink();
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.h),
                          bottomRight: Radius.circular(12.h),
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      backgroundColor: AppColor.blackColor,
                      titleSpacing: 0,
                      expandedHeight: 250.0.v,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 15.v),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.userModel.name ?? '',
                                  style: textTheme.titleLarge!.copyWith(
                                      color: Colors.white, fontSize: 16.fSize)),
                              Container(
                                padding: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.h)),
                                child: CustomImageView(
                                    height: 15.h,
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(
                                              AppRoutes.editUserProfileScreen)
                                          .then((_) {
                                        context
                                            .read<ProfileBloc>()
                                            .add(FetchProfile());
                                      });
                                    },
                                    imagePath: ImageConstant.editIcon),
                              )
                            ],
                          ),
                          background: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.h),
                              bottomRight: Radius.circular(12.h),
                            ),
                            child: Image.network(
                              state.userModel.profileImg ?? '',
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                  ];
                },
                body: Padding(
                  padding: EdgeInsets.all(20.0.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            menuItem.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: 16.v),
                              child: InkWell(
                                onTap: () {
                                  _getPages(index, context);
                                },
                                child: Container(
                                  height: 44.v,
                                  width: SizeUtils.width,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColor.offWhite))),
                                  child: Text(
                                    menuItem[index],
                                    style: textTheme.titleMedium!.copyWith(
                                        fontSize: 18.fSize,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.v),
                        // Text(
                        //   'Recently Viewed',
                        //   style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                        // ),
                        // SizedBox(height: 8.v),
                        // SizedBox(
                        //   height: 185.v,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: imagesList.length,
                        //       itemBuilder: (context, index) => CustomImageView(
                        //           onTap: () {},
                        //           margin: EdgeInsets.only(right: 8.h),
                        //           imagePath: imagesList[index],
                        //           radius: BorderRadius.circular(12.h))),
                        // )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _getPages(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(AppRoutes.followingScreen);
        break;

      case 1:
        Navigator.of(context).pushNamed(AppRoutes.wishlistScreen);
        break;

      case 2:
        Navigator.of(context).pushNamed(AppRoutes.myOrderScreen);
        break;

      case 3:
        Navigator.of(context).pushNamed(AppRoutes.helpCentreScreen);
        break;

      case 4:
        Navigator.of(context).pushNamed(AppRoutes.privacyPolicyScreen);
        break;

      case 5:
        Navigator.of(context).pushNamed(AppRoutes.settingScreen);
        break;

      case 6:
        logOutDialog(context);
        break;
      default:
    }
  }
}

List menuItem = [
  'Following',
  'Wishlist',
  'Orders',
  'Help Center',
  'Privacy',
  'Settings',
  'Log Out',
];

logOutDialog(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actionsPadding: EdgeInsets.all(25.v),
            title: Text(
              'Logout ?',
              style: textTheme.titleLarge!.copyWith(fontSize: 20.fSize),
            ),
            content: Text(
              'Are you sure want to logout...?',
              style: textTheme.bodySmall!.copyWith(fontSize: 20.fSize),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomOutlineButton(
                  width: 100.h,
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CustomElevatedButton(
                  width: 100.h,
                  text: 'Ok',
                  onPressed: () async {
                    await FirebaseServices.handleLogOut(context);
                  }),
            ],
          ));
}
