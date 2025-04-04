import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/all_influencer_bloc/bloc/all_influencer_bloc.dart';
import 'package:laiza/data/blocs/product_from_influencer_bloc/product_from_influencer_bloc.dart';
import 'package:laiza/data/blocs/reel_from_followed_influencer/reel_from_followed_influencer_bloc.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/creator/bloc/creator_bloc.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';
import 'package:laiza/widgets/influencer_card_widget.dart';

import '../../../data/blocs/following_bloc/following_bloc.dart';
import '../../../data/models/followers_model/follower.dart';
import '../../../data/models/reels_model/reel.dart';
import '../../../widgets/influencer_profile_card_widget.dart';

// ignore: must_be_immutable
class CreatorScreen extends StatelessWidget {
  const CreatorScreen({super.key});

  // int _selectedChip = 1;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (BuildContext context) => CreatorBloc(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                Text(
                  'Influencers You Follow',
                  style: textTheme.titleLarge!.copyWith(
                      fontSize: 20.fSize, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20.v),
                BlocProvider(
                  create: (context) =>
                      FollowingBloc(context.read<FollowersRepository>()),
                  child: BlocBuilder<FollowingBloc, FollowingState>(
                    builder: (context, state) {
                      if (state is FollowingInitial) {
                        context.read<FollowingBloc>().add(FetchFollowings());
                        return HorizontalLoadingListPage(
                            width: 130.h, height: 130.v);
                      } else if (state is FollowingLoading) {
                        return HorizontalLoadingListPage(
                            width: 130.h, height: 130.v);
                      } else if (state is FollowingErrorState) {
                        return Center(child: Text(state.message));
                      } else if (state is FollowingLoadedState) {
                        return SizedBox(
                          height: 130.v,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.followings.length,
                              itemBuilder: (BuildContext context, int index) {
                                Follower following = state.followings[index];
                                return Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: profileWidget(context, following),
                                );
                              }),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 20.v),
                // SizedBox(
                //   height: 36.v,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext context, int index) => InkWell(
                //       onTap: () {
                //         context
                //             .read<CreatorBloc>()
                //             .add(CreatorsCategoryChipSelectedEvent(index));
                //       },
                //       child: BlocConsumer<CreatorBloc, CreatorState>(
                //         listener: (BuildContext context, state) {
                //           if (state is CreatorsCategoryChipSelectedState) {
                //             _selectedChip = state.categoryId;
                //           }
                //         },
                //         builder: (BuildContext context, state) {
                //           return AnimatedContainer(
                //             duration: const Duration(milliseconds: 400),
                //             margin: EdgeInsets.only(right: 12.h),
                //             height: 36.v,
                //             width: 89.h,
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: Colors.black),
                //                 color: _selectedChip == index
                //                     ? Colors.black
                //                     : Colors.white,
                //                 borderRadius: BorderRadius.circular(24.h)),
                //             child: AnimatedDefaultTextStyle(
                //               duration: const Duration(milliseconds: 400),
                //               style: textTheme.labelSmall!.copyWith(
                //                   color: _selectedChip == index
                //                       ? Colors.white
                //                       : null),
                //               child: const Text(
                //                 'Fashion',
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                Text(
                  'Product from your Influencers',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 20.v),
                BlocProvider(
                  create: (context) => ProductFromInfluencerBloc(
                      context.read<ProductRepository>()),
                  child: BlocBuilder<ProductFromInfluencerBloc,
                      ProductFromInfluencerState>(
                    builder: (context, state) {
                      if (state is ProductFromInfluencerInitial) {
                        context
                            .read<ProductFromInfluencerBloc>()
                            .add(FetchProductFromInfluencer());
                        return HorizontalLoadingListPage(
                            height: 240.v, width: 150.h);
                      } else if (state is ProductFromInfluencerLoading) {
                        return HorizontalLoadingListPage(
                            height: 240.v, width: 150.h);
                      } else if (state is ProductFromInfluencerError) {
                        return Center(child: Text(state.message));
                      } else if (state is ProductFromInfluencerLoaded) {
                        return state.products.isEmpty
                            ? CustomImageView(
                                alignment: Alignment.center,
                                height: 120.v,
                                imagePath: ImageConstant.noPostFound)
                            : SizedBox(
                                height: 240.v,
                                child: ListView.builder(
                                  itemCount: state.products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ReelProduct product = state.products[index];
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.h),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              AppRoutes.productDetailScreen,
                                              arguments: product.id);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                              radius:
                                                  BorderRadius.circular(6.h),
                                              height: 150.v,
                                              width: 150.h,
                                              fit: BoxFit.fill,
                                              imagePath: product.productImage,
                                            ),
                                            SizedBox(height: 4.v),
                                            // Text(
                                            //   product.,
                                            //   style: textTheme.bodySmall,
                                            // ),
                                            SizedBox(height: 6.v),
                                            Text(
                                              product.productName,
                                              style: textTheme.titleMedium,
                                            ),
                                            SizedBox(height: 6.v),
                                            Text(
                                              '₹ ${product.price}',
                                              style: textTheme.bodySmall,
                                            ),
                                            SizedBox(height: 8.v),
                                            Center(
                                              child: CustomElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pushNamed(
                                                      AppRoutes
                                                          .productDetailScreen,
                                                      arguments: product.id);
                                                },
                                                width: 150.h,
                                                height: 26.v,
                                                text: 'Buy Now',
                                                buttonTextStyle: textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontSize: 12.fSize),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 20.v),
                Text(
                  'Meet the Trendsetters',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 2.v),
                Text(
                  'Discover the most buzz-worthy creators driving the latest trends. Tap to explore their reels and products.',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                BlocProvider(
                  create: (context) => ReelFromFollowedInfluencerBloc(
                      context.read<ReelRepository>()),
                  child: BlocBuilder<ReelFromFollowedInfluencerBloc,
                      ReelFromFollowedInfluencerState>(
                    builder: (context, state) {
                      if (state is ReelFromFollowedInfluencerInitial) {
                        context
                            .read<ReelFromFollowedInfluencerBloc>()
                            .add(FetchReelFromFollowedInfluencer());
                        return HorizontalLoadingListPage(
                            height: 261.v, width: 185.h);
                      } else if (state is ReelFromFollowedInfluencerLoading) {
                        return HorizontalLoadingListPage(
                            height: 261.v, width: 185.h);
                      } else if (state is ReelFromFollowedInfluencerError) {
                        return Center(child: Text(state.message));
                      } else if (state is ReelFromFollowedInfluencerLoaded) {
                        return state.reel.isEmpty
                            ? CustomImageView(
                                alignment: Alignment.center,
                                height: 120.v,
                                imagePath: ImageConstant.noPostFound)
                            : SizedBox(
                                height: 261.v,
                                child: ListView.builder(
                                    itemCount: state.reel.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, index) {
                                      Reel reel = state.reel[index];
                                      return Padding(
                                        padding: EdgeInsets.only(right: 5.h),
                                        child: InfluencerCardWidget(reel: reel),
                                      );
                                    }));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 28.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover and Follow New Creators',
                      style: textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.allCreatorsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.v),
                BlocProvider(
                  create: (BuildContext context) => AllInfluencerBloc(
                      context.read<UserRepository>(),
                      context.read<FollowersRepository>()),
                  child: BlocBuilder<AllInfluencerBloc, AllInfluencerState>(
                    builder: (BuildContext context, AllInfluencerState state) {
                      if (state is AllInfluencerInitial) {
                        context
                            .read<AllInfluencerBloc>()
                            .add(FetchAllInfluencer());
                        return const LoadingGridScreen();
                      }
                      if (state is AllInfluencerLoading) {
                        return const LoadingGridScreen();
                      } else if (state is AllInfluencerError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is AllInfluencerLoaded) {
                        return MasonryGridView.builder(
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          shrinkWrap: true,
                          // itemCount: state.influencers.length,
                          itemCount: state.influencers.length > 4
                              ? 4
                              : state.influencers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          mainAxisSpacing: 5.v,
                          crossAxisSpacing: 5.h,
                          itemBuilder: (BuildContext context, index) {
                            return InfluencerProfileCardWidget(
                                userModel: state.influencers[index]);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileWidget(BuildContext context, Follower following) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
            arguments: following.followedId.toString());
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Outer colored border
              Container(
                width: 82.v,
                height: 82.v,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
              ),
              // Inner content
              Container(
                width: 75.v,
                height: 75.v,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CustomImageView(
                  radius: BorderRadius.circular(80),
                  width: 82.v,
                  height: 82.v,
                  imagePath: following.profileImg,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            following.name,
            style: textTheme.titleMedium,
          ),
          // Row(
          //   children: [
          //     Container(
          //       height: 8.v,
          //       width: 8.h,
          //       decoration: const BoxDecoration(
          //           shape: BoxShape.circle, color: Colors.red),
          //     ),
          //     SizedBox(width: 5.h),
          //     Text(
          //       '4 New Post ',
          //       style: textTheme.bodySmall,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
