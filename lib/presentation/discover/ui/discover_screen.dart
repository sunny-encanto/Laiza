import 'package:laiza/data/blocs/advertisement_bloc/advertisement_bloc.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/repositories/advertisement_repository/advertisement_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';

import '../../../core/app_export.dart';
import '../../../data/blocs/product_bloc/product_bloc.dart';
import '../../../data/blocs/reel_from_followed_influencer/reel_from_followed_influencer_bloc.dart';
import '../../../data/models/reels_model/reel.dart';
import '../../../data/repositories/reel_repository/reel_repository.dart';
import '../../../widgets/influencer_card_widget.dart';
import '../../../widgets/slider_widget.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: customAppBar(context),
      body: BlocProvider(
        create: (BuildContext context) => DiscoverBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                // SizedBox(
                //   height: 36.v,
                //   child: ListView.separated(
                //     separatorBuilder: (BuildContext context, int index) =>
                //         Divider(height: 2.v),
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 5,
                //     itemBuilder: (BuildContext context, index) =>
                //         BlocConsumer<DiscoverBloc, DiscoverState>(
                //       listener: (BuildContext context, DiscoverState state) {
                //         if (state is DiscoverChipSelectState) {
                //           selectedIndex = state.selectedIndex;
                //         }
                //       },
                //       builder: (BuildContext context, DiscoverState state) {
                //         return InkWell(
                //           onTap: () {
                //             context
                //                 .read<DiscoverBloc>()
                //                 .add(DiscoverChipSelectEvent(index));
                //           },
                //           child: AnimatedContainer(
                //               duration: const Duration(milliseconds: 400),
                //               margin: EdgeInsets.only(right: 12.h),
                //               height: 36.v,
                //               width: 89.h,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                   border: Border.all(color: Colors.black),
                //                   color: selectedIndex == index
                //                       ? Colors.black
                //                       : Colors.white,
                //                   borderRadius: BorderRadius.circular(24.h)),
                //               child: AnimatedDefaultTextStyle(
                //                 duration: const Duration(milliseconds: 400),
                //                 style: textTheme.labelSmall!.copyWith(
                //                   color: selectedIndex == index
                //                       ? Colors.white
                //                       : null,
                //                 ),
                //                 child: const Text('Following'),
                //               )),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // SizedBox(height: 24.v),
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
                Container(
                    constraints: BoxConstraints(maxHeight: 500.v),
                    child: const TrendingItemGridWidget(
                        physics: NeverScrollableScrollPhysics())),

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
                        return const LoadingGridScreen();
                      } else if (state is ReelFromFollowedInfluencerLoading) {
                        return const LoadingGridScreen();
                      } else if (state is ReelFromFollowedInfluencerError) {
                        return Center(child: Text(state.message));
                      } else if (state is ReelFromFollowedInfluencerLoaded) {
                        return state.reel.isEmpty
                            ? CustomImageView(
                                alignment: Alignment.center,
                                height: 120.v,
                                imagePath: ImageConstant.noPostFound)
                            : Container(
                                constraints: BoxConstraints(maxHeight: 690.v),
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
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                      ),
                                    ],
                                  ),
                                  childrenDelegate: SliverChildBuilderDelegate(
                                      childCount: state.reel.length,
                                      (BuildContext context, int index) {
                                    Reel reel = state.reel[index];
                                    return InfluencerCardWidget(reel: reel);
                                  }),
                                ),
                              );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                // BlocProvider(
                //     create: (context) =>
                //         ReelBloc(context.read<ReelRepository>()),
                //     child: BlocBuilder<ReelBloc, ReelState>(
                //         buildWhen: (previous, current) =>
                //             (current is ReelLoading ||
                //                 current is ReelLoaded ||
                //                 current is ReelError),
                //         builder: (context, state) {
                //           if (state is ReelInitial) {
                //             context.read<ReelBloc>().add(LoadReelEvent());
                //           } else if (state is ReelLoading) {
                //             return const LoadingGridScreen();
                //           } else if (state is ReelError) {
                //             return Center(
                //               child: Text(state.message),
                //             );
                //           } else if (state is ReelLoaded) {
                //             return
                //               SizedBox(
                //               height: 690.v,
                //               child: GridView.custom(
                //                 shrinkWrap: true,
                //                 padding: const EdgeInsets.all(0),
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 gridDelegate: SliverWovenGridDelegate.count(
                //                   crossAxisCount: 2,
                //                   mainAxisSpacing: 0,
                //                   crossAxisSpacing: 0,
                //                   pattern: [
                //                     const WovenGridTile(1),
                //                     const WovenGridTile(
                //                       5 / 7,
                //                       crossAxisRatio: 0.9,
                //                       alignment: AlignmentDirectional.centerEnd,
                //                     ),
                //                   ],
                //                 ),
                //                 childrenDelegate: SliverChildBuilderDelegate(
                //                   childCount: state.reels.length,
                //                   (BuildContext context, int index) =>
                //                       InfluencerCardWidget(
                //                           reel: state.reels[index]),
                //                 ),
                //               ),
                //             );
                //           }
                //           return const SizedBox.shrink();
                //         })),
                SizedBox(height: 24.v),
                _buildDiscoverCard(),
                SizedBox(height: 24.v),
                Text(
                  'Explore More Products',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 2.v),
                Text(
                  'Endless options tailored just for you—scroll through to find what you love!',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                BlocProvider(
                  create: (_) => ProductBloc(context.read<ProductRepository>())
                    ..add(LoadProducts()),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const LoadingGridScreen();
                      } else if (state is ProductError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is ProductLoaded) {
                        return state.products.isEmpty
                            ? CustomImageView(
                                alignment: Alignment.center,
                                height: 120.v,
                                imagePath: ImageConstant.noPostFound)
                            : MasonryGridView.builder(
                                gridDelegate:
                                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                itemCount: state.products.length,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 15.v,
                                crossAxisSpacing: 10.h,
                                itemBuilder: (BuildContext context, int index) {
                                  final Product product = state.products[index];
                                  return ProductCardWidget(product: product);
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

  _buildDiscoverCard() {
    return BlocProvider(
      create: (context) =>
          AdvertisementBloc(context.read<AdvertisementRepository>()),
      child: BlocBuilder<AdvertisementBloc, AdvertisementState>(
        builder: (context, state) {
          if (state is AdvertisementInitial) {
            context.read<AdvertisementBloc>().add(FetchAdvertisementEvent());
            return SizedBox(height: 186.v, width: SizeUtils.width);
          } else if (state is AdvertisementLoading) {
            return SizedBox(height: 186.v, width: SizeUtils.width);
          } else if (state is AdvertisementError) {
            return Center(child: Text(state.message));
          } else if (state is AdvertisementLoaded) {
            if (state.advertisement.isNotEmpty) {
              return customSlider(
                height: 170.v,
                autoPlay: state.advertisement.length > 1,
                childList: List.generate(
                  state.advertisement.length,
                  (sliderIndex) => CustomImageView(
                    margin: EdgeInsets.only(right: 2.h),
                    height: 170.v,
                    width: SizeUtils.width,
                    radius: BorderRadius.circular(12.h),
                    imagePath: state.advertisement[sliderIndex].image,
                  ),
                ),
              );
              //   Stack(
              //   clipBehavior: Clip.hardEdge,
              //   alignment: Alignment.bottomLeft,
              //   children: [
              //     CustomImageView(
              //       height: 186.v,
              //       width: SizeUtils.width,
              //       radius: BorderRadius.circular(12.h),
              //       imagePath: advertisement.image,
              //       fit: BoxFit.fill,
              //     ),
              //   ],
              // );
            } else {
              return SizedBox(height: 186.v);
            }
          }
          return const SizedBox.shrink();
        },
      ),
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
