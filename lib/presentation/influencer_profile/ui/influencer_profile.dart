import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/data/blocs/influencer_profile_bloc/influencer_profile_bloc.dart';
import 'package:laiza/data/models/influencer_profile_model/influencer_profile_model.dart';
import 'package:laiza/data/services/share.dart';
import 'package:laiza/presentation/influencer_profile/ui/product_view/product_view.dart';
import 'package:laiza/widgets/custom_popup_menu_button.dart';

import '../../../data/models/user/user_model.dart';
import 'post_view/post_view.dart';

class InfluencerProfileScreen extends StatelessWidget {
  final String id;

  InfluencerProfileScreen({super.key, required this.id});

  bool _isFollowed = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<InfluencerProfileBloc, InfluencerProfileState>(
          buildWhen: (previous, current) =>
              (current is InfluencerProfileInitial ||
                  current is InfluencerProfileLoading ||
                  current is InfluencerProfileError ||
                  current is InfluencerProfileLoaded),
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
              _isFollowed =
                  state.influencerProfileModel.data.influencer.isFollowed ??
                      false;
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: [
                        CustomPopupMenuButton(
                            menuItems: const [
                              PopupMenuItem(
                                value: 1,
                                child: Text('Report User'),
                              )
                            ],
                            onItemSelected: (val) {
                              if (val == 1) {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.reportUserScreen,
                                    arguments: '1');
                              }
                            })
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
                            //Profile Background
                            CustomImageView(
                              width: SizeUtils.width,
                              height: 150.v,
                              imagePath: state.influencerProfileModel.data
                                  .influencer.profileBg,
                              fit: BoxFit.fill,
                            ),
                            //Profile Card
                            _buildProfileCard(
                                textTheme,
                                state.influencerProfileModel.data.influencer,
                                context),
                            SizedBox(height: 12.h),
                            //Bio
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
                                    maxLines: 4,
                                  ),
                                  SizedBox(height: 24.h),
                                  Text(
                                    'Collections',
                                    style: textTheme.titleMedium!
                                        .copyWith(fontSize: 16.fSize),
                                  ),
                                  SizedBox(height: 24.v),
                                  state.influencerProfileModel.data.collections
                                          .isEmpty
                                      ? Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomImageView(
                                                imagePath:
                                                    ImageConstant.noPostFound,
                                                height: 100.v,
                                              ),
                                              SizedBox(height: 15.v),
                                              Text(
                                                'No Collections Yet',
                                                style: textTheme.titleMedium,
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          height: 185.v,
                                          child: ListView.builder(
                                              itemCount: state
                                                  .influencerProfileModel
                                                  .data
                                                  .collections
                                                  .length,
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
                                  _buildNotifyMeBanner(
                                      textTheme,
                                      state.influencerProfileModel.data
                                          .influencer),
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

  Container _buildNotifyMeBanner(TextTheme textTheme, UserModel user) {
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
                          text: ' ${user.name}',
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
              imagePath: user.profileImg,
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

  Row _buildProfileCard(
      TextTheme textTheme, UserModel user, BuildContext context) {
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
                BlocBuilder<InfluencerProfileBloc, InfluencerProfileState>(
                  builder: (context, followState) {
                    if (followState is InfluencerProfileToggleFollowState) {
                      // _isFollowed = followState.isFollowed;
                      return CustomElevatedButton(
                        buttonTextStyle: textTheme.titleSmall,
                        height: 38.v,
                        width: 122.h,
                        text: followState.isFollowed ? "Following" : 'Follow',
                        onPressed: () {
                          _isFollowed = !_isFollowed;
                          context.read<InfluencerProfileBloc>().add(
                              InfluencerProfileToggleFollowEvent(
                                  id: user.id ?? "", isFollowed: _isFollowed));
                        },
                      );
                    }

                    return CustomElevatedButton(
                      buttonTextStyle: textTheme.titleSmall,
                      height: 38.v,
                      width: 122.h,
                      text: _isFollowed ? "Following" : 'Follow',
                      onPressed: () {
                        _isFollowed = !_isFollowed;
                        context.read<InfluencerProfileBloc>().add(
                            InfluencerProfileToggleFollowEvent(
                                id: user.id ?? "", isFollowed: _isFollowed));
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
        CustomImageView(
          onTap: () {
            shareContent('${ApiConstant.baseUrlWeb}/profile?id=${user.id}');
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
          Navigator.of(context).pushNamed(AppRoutes.collectionViewScreen,
              arguments: collection.id);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Image
                  collection.reels.isNotEmpty
                      ? CustomImageView(
                          width: collection.reels.length < 2 ? 124 : 61.h,
                          height: 124.v,
                          imagePath: collection.reels[0].reelCoverPath,
                          fit: BoxFit.fill,
                        )
                      : Container(color: Colors.grey),
                  const SizedBox(width: 4),
                  // Secondary Images
                  Column(
                    children: [
                      if (collection.reels.length > 1)
                        CustomImageView(
                          width: 61.h,
                          height: collection.reels.length < 3 ? 124.v : 60.v,
                          imagePath: collection.reels[1].reelCoverPath,
                          fit: BoxFit.fill,
                        ),
                      if (collection.reels.length > 2)
                        const SizedBox(height: 4),
                      if (collection.reels.length > 2)
                        CustomImageView(
                          width: 61.h,
                          height: 60.v,
                          imagePath: collection.reels[2].reelCoverPath,
                          fit: BoxFit.fill,
                        )
                    ],
                  ),
                ],
              ),
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
