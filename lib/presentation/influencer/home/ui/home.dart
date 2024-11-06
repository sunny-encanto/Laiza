import 'package:laiza/core/app_export.dart';

import '../../../../data/models/connections_model/connections_model.dart';
import '../../side_bar/ui/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const SideBar(),
      appBar: customAppBar(context),
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        prefixConstraints: BoxConstraints(maxWidth: 25.h),
                        prefix: Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: CustomImageView(
                            width: 15.h,
                            imagePath: ImageConstant.searchIcon,
                          ),
                        ),
                        hintText: 'Search for product or seller',
                      ),
                    ),
                    SizedBox(width: 16.h),
                    CustomIconButton(
                      icon: ImageConstant.request,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.connectionsRequestScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 46.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: index == 0
                          ? Chip(
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
                                    style: textTheme.bodySmall!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ))
                          : Chip(
                              shape: StadiumBorder(
                                  side: BorderSide(color: AppColor.primary)),
                              backgroundColor: Colors.white,
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Product',
                                    style: textTheme.bodySmall!
                                        .copyWith(color: AppColor.primary),
                                  ),
                                  SizedBox(width: 5.h),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColor.primary,
                                  )
                                ],
                              )),
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                Text(
                  'Products from your connections',
                  style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 330.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10.h),
                      child: _buildProductCart(textTheme),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Connections',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.connectionsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 280.v,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) => _buildConnectionItem(
                          connectionsList[index], textTheme)),
                ),
                SizedBox(height: 28.v),
                Text(
                  'Promote These Hot Products',
                  style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 330.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10.h),
                      child: _buildProductCart(textTheme),
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Sellers to Collaborate',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.discoverConnectionsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 250.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10.h),
                      child: Container(
                        width: 185.h,
                        decoration: BoxDecoration(
                            color: AppColor.offWhite,
                            borderRadius: BorderRadius.circular(12.h)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              height: 100.h,
                              width: 100.h,
                              radius: BorderRadius.circular(100.h),
                              imagePath: ImageConstant.bannerGirl,
                            ),
                            Text(
                              'Amrita Ghosh',
                              style: textTheme.titleMedium!
                                  .copyWith(fontSize: 16.fSize),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.categoryIcon),
                                SizedBox(width: 5.h),
                                Text('Cosmetics', style: textTheme.bodySmall),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            CustomElevatedButton(
                              width: 122.h,
                              height: 33.v,
                              text: 'View Profile',
                              buttonTextStyle: textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
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

  ListTile _buildConnectionItem(ConnectionsModel items, TextTheme textTheme) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: items.profile,
      ),
      trailing: CustomImageView(
        imagePath: ImageConstant.chatIcon,
      ),
      title: Text(
        items.name,
        style: textTheme.titleMedium,
      ),
      subtitle: Row(
        children: [
          Text(
            'Product Category- ',
            style: textTheme.bodySmall,
          ),
          Text(
            items.category,
            style: textTheme.bodySmall!.copyWith(color: AppColor.blackColor),
          ),
        ],
      ),
    );
  }

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
        centerTitle: true,
        leadingWidth: 70.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Builder(builder: (context) {
            return CustomIconButton(
                icon: ImageConstant.menu,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
        ),
        title: CustomImageView(
          width: 98.h,
          imagePath: ImageConstant.logo,
        ),
        actions: [
          CustomIconButton(
            icon: ImageConstant.bellIcon,
            onTap: () async {
              Navigator.of(context).pushNamed(AppRoutes.notificationsScreen);
            },
          ),
          SizedBox(width: 8.h),
          CustomIconButton(
            icon: ImageConstant.message,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.chatsScreen);
            },
          ),
          SizedBox(width: 8.h),
        ],
      ),
    );
  }
}
