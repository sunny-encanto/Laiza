import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColor.blackColor,
              titleSpacing: 0,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.translate('elizabethSwann'),
                          style: textTheme.titleLarge!
                              .copyWith(color: Colors.white)),
                      CustomImageView(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.notificationsScreen);
                          },
                          imagePath: ImageConstant.notificationIcon)
                    ],
                  ),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
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
                    (index) => InkWell(
                      onTap: () {
                        _getPages(index, context);
                      },
                      child: Container(
                        height: 44.v,
                        width: SizeUtils.width,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: AppColor.offWhite))),
                        child: Text(
                          menuItem[index],
                          style: textTheme.titleMedium!
                              .copyWith(fontSize: 18.fSize),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                Text(
                  'Recently Viewed',
                  style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                ),
                SizedBox(height: 8.v),
                SizedBox(
                  height: 185.v,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imagesList.length,
                      itemBuilder: (context, index) => CustomImageView(
                          onTap: () {},
                          margin: EdgeInsets.only(right: 8.h),
                          imagePath: imagesList[index],
                          radius: BorderRadius.circular(12.h))),
                )
              ],
            ),
          ),
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
        break;

      case 6:
        logOutDialog(context);
        break;
      default:
    }
  }

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
