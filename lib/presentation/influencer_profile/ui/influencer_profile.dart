import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/influencer_profile_bloc/influencer_profile_bloc.dart';
import 'package:laiza/data/models/influencer_profile_model/influencer_profile_model.dart';
import 'package:laiza/data/services/share.dart';
import 'package:laiza/presentation/influencer_profile/ui/post_view/post_view.dart';
import 'package:laiza/presentation/influencer_profile/ui/product_view/product_view.dart';

import '../../../data/models/user/user_model.dart';

class InfluencerProfileScreen extends StatelessWidget {
  final String id;

  const InfluencerProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<InfluencerProfileBloc, InfluencerProfileState>(
          builder: (context, state) {
            if (state is InfluencerProfileInitial) {
              context
                  .read<InfluencerProfileBloc>()
                  .add(FetchInfluencerProfileEvent(id));
              return const SizedBox.shrink();
            } else if (state is InfluencerProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InfluencerProfileError) {
              return Center(child: Text(state.message));
            } else if (state is InfluencerProfileLoaded) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: const [
                        Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        )
                      ],
                      iconTheme: const IconThemeData(color: Colors.black),
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size(SizeUtils.width, 60.v),
                        child: Container(
                          color: Colors.white,
                          child: TabBar(
                            tabAlignment: TabAlignment.fill,
                            indicatorColor: AppColor.primary,
                            labelColor: AppColor.primary,
                            tabs: const [
                              Tab(
                                text: 'Post',
                              ),
                              Tab(
                                text: 'Product',
                              ),
                            ],
                          ),
                        ),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      expandedHeight: SizeUtils.height - 100.v,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              width: SizeUtils.width,
                              height: 150.v,
                              imagePath: ImageConstant.profileBg,
                            ),
                            _buildProfileCard(textTheme,
                                state.influencerProfileModel.data.influencer),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.influencerProfileModel.data.influencer
                                            .username ??
                                        '',
                                    style: textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    state.influencerProfileModel.data.influencer
                                            .bio ??
                                        '',
                                    style: textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 24.h),
                                  Text(
                                    'Top Products',
                                    style: textTheme.titleMedium!
                                        .copyWith(fontSize: 16.fSize),
                                  ),
                                  SizedBox(height: 24.v),
                                  SizedBox(
                                    height: 185.v,
                                    child: ListView.builder(
                                        itemCount: state.influencerProfileModel
                                            .data.collections.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          Collection collection = state
                                              .influencerProfileModel
                                              .data
                                              .collections[index];
                                          return CollectionCardWidget(
                                              collection: collection);
                                        }),
                                  ),
                                  // _buildTopProductItem(state
                                  //     .influencerProfileModel.data.collections),
                                  SizedBox(height: 18.v),
                                  _buildNotifyMeBanner(textTheme),
                                  SizedBox(height: 24.v),
                                  SizedBox(height: 24.v),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.v),
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                          child: PostView(
                              reel: state
                                  .influencerProfileModel.data.trendingReels)),
                      SingleChildScrollView(
                          child: ProductView(
                        products: state.influencerProfileModel.data.products,
                      ))
                    ],
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

  // Padding _buildCollectionCard(BuildContext context, Collection collection) {
  //   TextTheme textTheme = Theme.of(context).textTheme;
  //   return ;
  // }

  Container _buildNotifyMeBanner(TextTheme textTheme) {
    return Container(
      width: SizeUtils.width,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.h), color: AppColor.lightPink),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Catch ',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF525252),
                        fontWeight: FontWeight.w800,
                        fontSize: 14.fSize),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Carol Danvers',
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.pink,
                            fontWeight: FontWeight.w800,
                            fontSize: 14.fSize,
                          )),
                      TextSpan(
                        text:
                            ' live on upcoming sessions where they’ll share product tips, fashion advice, and more!!',
                        style: GoogleFonts.roboto(
                            color: const Color(0xFF525252),
                            fontWeight: FontWeight.w800,
                            fontSize: 14.fSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                CustomElevatedButton(
                  width: 128.h,
                  height: 21.v,
                  backgroundColor: Colors.white,
                  text: 'Notify me',
                  buttonTextStyle: textTheme.bodySmall!.copyWith(
                      color: Colors.pink,
                      fontSize: 10.fSize,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(100.h),
            ),
            child: CustomImageView(
              radius: BorderRadius.circular(100.h),
              width: 80.v,
              height: 80.v,
              fit: BoxFit.fill,
              imagePath:
                  'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
            ),
          ),
        ],
      ),
    );
  }

  // SizedBox _buildTopProductItem(List<Collection> collection) {
  //   return SizedBox(
  //     height: 150.v,
  //     child: ListView.builder(
  //       itemCount: collection.length,
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) => Padding(
  //         padding: EdgeInsets.only(right: 24.h),
  //         child: Column(
  //           children: [
  //             CustomImageView(
  //               height: 100.v,
  //               width: 100.h,
  //               fit: BoxFit.fill,
  //               radius: BorderRadius.circular(6.h),
  //               imagePath: collection[index].
  //                   ? ImageConstant.imageNotFound
  //                   : products[index].images[0].imagePath,
  //             ),
  //             SizedBox(height: 4.v),
  //             SizedBox(width: 100.h, child: const Text('Lino Perros Women'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Row _buildProfileCard(TextTheme textTheme, UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(5.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(100.h),
              ),
              child: CustomImageView(
                radius: BorderRadius.circular(100.h),
                width: 105.v,
                height: 105.v,
                fit: BoxFit.fill,
                imagePath: user.profileImg,
              ),
            ),
            SizedBox(width: 12.h),
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      user.name ?? '',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      '${user.followersCount} Followers',
                      style: textTheme.bodySmall!.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                CustomElevatedButton(
                    buttonTextStyle: textTheme.titleSmall,
                    height: 38.v,
                    width: 122.h,
                    text: 'Follow ')
              ],
            ),
          ],
        ),
        CustomImageView(
          onTap: () {
            shareContent('Profile url');
          },
          imagePath: ImageConstant.shareIcon,
          color: Colors.black,
        )
      ],
    );
  }
}

class CollectionCardWidget extends StatelessWidget {
  const CollectionCardWidget({super.key, required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: 12.h),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.collectionViewScreen);
        },
        child: Container(
          padding: EdgeInsets.all(8.h),
          // width: 125.h,
          height: 167.v,
          decoration: BoxDecoration(
              color: AppColor.offWhite,
              borderRadius: BorderRadius.circular(6.h)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Main Image
                  collection.reels.isNotEmpty
                      ? Image.network(
                          collection.reels[0].reelCoverPath,
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.grey),
                  const SizedBox(width: 4),
                  // Secondary Images
                  Column(
                    children: [
                      if (collection.reels.length > 1)
                        Image.network(
                          collection.reels[1].reelCoverPath,
                          fit: BoxFit.cover,
                        ),
                      if (collection.reels.length > 2)
                        const SizedBox(height: 4),
                      if (collection.reels.length > 2)
                        Image.network(
                          collection.reels[2].reelCoverPath,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     CustomImageView(
              //       width: 61.h,
              //       height: 117.v,
              //       fit: BoxFit.fill,
              //       imagePath: collection.reels[0].reelCoverPath,
              //     ),
              //     SizedBox(width: 2.h),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         CustomImageView(
              //           width: 52.h,
              //           height: 52.v,
              //           fit: BoxFit.fill,
              //           imagePath: imagesList[1],
              //         ),
              //         SizedBox(height: 2.v),
              //         CustomImageView(
              //           width: 52.h,
              //           height: 62.v,
              //           fit: BoxFit.fill,
              //           imagePath: imagesList[2],
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              SizedBox(height: 4.v),
              Text(
                collection.title,
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 2.v),
              Text(
                '${collection.reels.length} Post',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
