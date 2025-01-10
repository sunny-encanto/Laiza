import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/services/firebase_services.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.v),
            Center(
                child: CustomImageView(
                    width: 150.h, imagePath: ImageConstant.logo)),
            SizedBox(height: 43.v),
            BlocProvider(
              create: (context) =>
                  ProfileApiBloc(context.read<UserRepository>()),
              child: BlocBuilder<ProfileApiBloc, ProfileApiState>(
                builder: (context, state) {
                  if (state is ProfileApiInitial) {
                    context.read<ProfileApiBloc>().add(FetchProfileApi());
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiLoadingState) {
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiError) {
                    return Text(state.message);
                  } else if (state is ProfileApiLoadedState) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(AppRoutes.influencerMyProfile);
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(100.h),
                            ),
                            child: CustomImageView(
                                radius: BorderRadius.circular(100.h),
                                width: 68.v,
                                height: 68.v,
                                fit: BoxFit.fill,
                                imagePath: state.userModel.profileImg
                                // 'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
                                ),
                          ),
                          SizedBox(width: 4.v),
                          Column(
                            children: [
                              Text(
                                state.userModel.username ?? '',
                                style: textTheme.titleMedium,
                              ),
                              SizedBox(height: 4.v),
                              Text(
                                '425K Followers',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black87,
                            size: 20.h,
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            SizedBox(height: 24.v),
            _buildSideBarItem(
              imagePath: ImageConstant.dashboard,
              tittle: 'Dashboard',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.dashboardScreen);
              },
              textTheme: textTheme,
            ),
            _buildSideBarItem(
              imagePath: ImageConstant.connections,
              tittle: 'Connections',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.connectionsScreen);
              },
              textTheme: textTheme,
            ),
            _buildSideBarItem(
              imagePath: ImageConstant.payments,
              tittle: 'Payments',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.earningsScreen);
              },
              textTheme: textTheme,
            ),
            _buildSideBarItem(
              imagePath: ImageConstant.orders,
              tittle: 'Orders',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(AppRoutes.orderManagementScreen);
              },
              textTheme: textTheme,
            ),
            _buildSideBarItem(
              imagePath: ImageConstant.settings,
              tittle: 'Settings',
              onTap: () {
                Navigator.of(context).pop();
              },
              textTheme: textTheme,
            ),
            _buildSideBarItem(
              imagePath: ImageConstant.logout,
              tittle: 'Log out',
              onTap: () async {
                await FirebaseServices.handleLogOut(context);
                // Navigator.of(context).pop();
              },
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }

  InkWell _buildSideBarItem({
    required String imagePath,
    required String tittle,
    required VoidCallback onTap,
    required TextTheme textTheme,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48.v,
        child: Row(
          children: [
            CustomImageView(
              imagePath: imagePath,
              color: Colors.black,
            ),
            SizedBox(width: 8.h),
            Text(
              tittle,
              style: textTheme.titleLarge!.copyWith(fontSize: 16.fSize),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
