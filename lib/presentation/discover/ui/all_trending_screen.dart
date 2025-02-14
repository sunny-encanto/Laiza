import 'package:laiza/core/app_export.dart';

import '../../../data/blocs/trending_now_bloc/trending_now_bloc.dart';
import '../../../data/models/reels_model/reel.dart';
import '../../../data/models/trending_items_model/trending_items_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../../widgets/play_button.dart';
import '../../Influencer_profile/ui/post_view/post_view.dart';
import '../../shimmers/loading_grid.dart';

class AllTrendingScreen extends StatelessWidget {
  const AllTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppColor.offWhite,
        title: Text(
          'Trending Now',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: const TrendingItemGridWidget(),
    );
  }
}

class TrendingItemGridWidget extends StatelessWidget {
  const TrendingItemGridWidget({super.key, this.physics});

  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingNowBloc(context.read<PostRepository>()),
      child: BlocBuilder<TrendingNowBloc, TrendingNowState>(
        builder: (context, state) {
          if (state is TrendingNowInitial) {
            context.read<TrendingNowBloc>().add(FetchTrendingNowEvent());
            return const LoadingGridScreen(radius: 0);
          } else if (state is TrendingNowInitial) {
            return const LoadingGridScreen(radius: 0);
          } else if (state is TrendingNowError) {
            return Center(child: Text(state.message));
          } else if (state is TrendingNowLoaded) {
            return RefreshIndicator(
              onRefresh: () => Future.sync(() {
                context.read<TrendingNowBloc>().add(FetchTrendingNowEvent());
              }),
              child: MasonryGridView.count(
                physics: physics,
                shrinkWrap: true,
                itemCount: state.trendingNow.length,
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemBuilder: (BuildContext context, index) {
                  TrendingItems trendingItems = state.trendingNow[index];
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 123.h,
                        // height: extent,
                        margin: EdgeInsets.all(1.0.h),
                        color: Colors.grey,
                        child: CustomImageView(
                          width: 123.h,
                          height: 123.v,
                          fit: BoxFit.fill,
                          onTap: () {
                            if (trendingItems.type ==
                                TrendingItemType.PRODUCT) {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.productDetailScreen,
                                  arguments: trendingItems.id);
                            }
                          },
                          imagePath: trendingItems.image,
                          // fit: BoxFit.fitWidth,
                        ),
                      ),
                      PlayButton(
                        isVisible: trendingItems.type == TrendingItemType.REEL,
                        onTap: () {
                          List<TrendingItems> reelItems = state.trendingNow
                              .where(
                                  (item) => item.type == TrendingItemType.REEL)
                              .toList();
                          List<Reel> reels = reelItems
                              .map((e) => Reel(
                                  id: e.id,
                                  userId: 0,
                                  productId: <String>[],
                                  catId: 0,
                                  reelTitle: '',
                                  reelPath: e.reelPath ?? '',
                                  likeStatus: e.isLike,
                                  reelDescription: '',
                                  reelCoverPath: e.image,
                                  reelHashtag: '',
                                  likesCount: 0,
                                  commentsCount: 0,
                                  product: <ReelProduct>[],
                                  user: UserModel()))
                              .toList();
                          int initialIndex = reels.indexWhere(
                              (item) => item.id == trendingItems.id);
                          if (trendingItems.type == TrendingItemType.REEL) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  VideoReelPageOtherInfluencer(
                                      initialIndex: initialIndex, reels: reels),
                            ));
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
