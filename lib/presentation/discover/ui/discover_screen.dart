import '../../../core/app_export.dart';
import '../../../widgets/influencer_card_widget.dart';
import '../../../widgets/influencer_profile_card_widget.dart';
import '../../../widgets/trending_card_widget.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    int selectedIndex = 0;
    return Scaffold(
      appBar: customAppBar(context),
      body: BlocProvider(
        create: (context) => DiscoverBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                SizedBox(
                  height: 36.v,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 2.v),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        BlocConsumer<DiscoverBloc, DiscoverState>(
                      listener: (BuildContext context, DiscoverState state) {
                        if (state is DiscoverChipSelectState) {
                          selectedIndex = state.selectedIndex;
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<DiscoverBloc>()
                                .add(DiscoverChipSelectEvent(index));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12.h),
                            height: 36.v,
                            width: 89.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: selectedIndex == index
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(24.h)),
                            child: Text('Following',
                                style: textTheme.labelSmall!.copyWith(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : null)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                _buildDiscoverCard(),
                SizedBox(height: 24.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Now',
                      style: textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.allTrendingScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.v),
                Text(
                  'Shop the hottest products handpicked by top creators and influencers',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 500.v,
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    itemCount: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    itemBuilder: (context, index) {
                      return TrendingCardWidget(
                        index: index,
                        extent: (index % 2 + 1) * 100,
                      );
                    },
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From Your Favorite Influencers',
                      style: textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.allFavInfluencerScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.v),
                Text(
                  'Stay up-to-date with the latest content and products from the influencers you follow',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 690.v,
                  child: GridView.custom(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      pattern: [
                        const WovenGridTile(1),
                        const WovenGridTile(
                          5 / 7,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      childCount: imagesList.length,
                      (context, index) => InfluencerCardWidget(index: index),
                    ),
                  ),
                ),
                SizedBox(height: 24.v),
                Text(
                  'Top Influencer Picks for You',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 2.v),
                Text(
                  'Follow these influencers to discover more products, deals, and recommendations',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                MasonryGridView.count(
                  shrinkWrap: true,
                  itemCount: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.v,
                  crossAxisSpacing: 5.h,
                  itemBuilder: (context, index) {
                    return const InfluencerProfileCardWidget();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDiscoverCard() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topRight,
      children: [
        Container(
          width: SizeUtils.width,
          height: 186.v,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.h),
              color: AppColor.blackColor),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.v, horizontal: 10.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 27.v),
                Text(
                  'Meet Our Creator of the Week',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.v),
                SizedBox(
                  width: SizeUtils.width - 150.h,
                  child: Text(
                      'Follow Natahsa for exclusive reels and product collaboration',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15.fSize,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                SizedBox(height: 24.v),
                CustomElevatedButton(
                  text: 'Follow Now',
                  width: 128.h,
                  height: 24.v,
                  buttonTextStyle: TextStyle(
                      fontSize: 10.fSize, color: const Color(0xffAD4B37)),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        CustomImageView(
          height: 186.v,
          width: 186.v,
          imagePath: ImageConstant.discoverBannerImage,
        ),
      ],
    );
  }
}

List imagesList = [
  'https://i.imgur.com/CzXTtJV.jpg',
  'https://i.imgur.com/OB0y6MR.jpg',
  'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
  'https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg',
  'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg',
  'https://i.imgur.com/OnwEDW3.jpg',
  'https://farm3.staticflickr.com/2220/1572613671_7311098b76_z_d.jpg',
  'https://farm7.staticflickr.com/6089/6115759179_86316c08ff_z_d.jpg',
  'https://farm2.staticflickr.com/1090/4595137268_0e3f2b9aa7_z_d.jpg',
  'https://farm4.staticflickr.com/3224/3081748027_0ee3d59fea_z_d.jpg',
  'https://farm8.staticflickr.com/7377/9359257263_81b080a039_z_d.jpg',
  'https://farm9.staticflickr.com/8295/8007075227_dc958c1fe6_z_d.jpg',
  'https://farm2.staticflickr.com/1449/24800673529_64272a66ec_z_d.jpg',
  'https://farm4.staticflickr.com/3752/9684880330_9b4698f7cb_z_d.jpg',
];
