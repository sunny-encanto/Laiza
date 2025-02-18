import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/reels_model/reel.dart';

import '../../../data/blocs/reel_from_followed_influencer/reel_from_followed_influencer_bloc.dart';
import '../../../data/repositories/reel_repository/reel_repository.dart';
import '../../../widgets/influencer_card_widget.dart';
import '../../shimmers/loading_grid.dart';

class AllFavInfluencerScreen extends StatelessWidget {
  const AllFavInfluencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite Influencers',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.h),
          child: BlocProvider(
            create: (context) =>
                ReelFromFollowedInfluencerBloc(context.read<ReelRepository>()),
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
                  return Container(
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
                            alignment: AlignmentDirectional.centerEnd,
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
        )
        // GridView.custom(
        //   shrinkWrap: true,
        //   padding: EdgeInsets.all(10.h),
        //   gridDelegate: SliverWovenGridDelegate.count(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 0,
        //     crossAxisSpacing: 0,
        //     pattern: [
        //       const WovenGridTile(1),
        //       const WovenGridTile(
        //         5 / 7,
        //         crossAxisRatio: 0.9,
        //         alignment: AlignmentDirectional.centerEnd,
        //       ),
        //     ],
        //   ),
        //   childrenDelegate: SliverChildBuilderDelegate(
        //     childCount: imagesList.length,
        //     (context, index) => InfluencerCardWidget(
        //         //Need to change here
        //         reel: Reel(
        //             id: 0,
        //             userId: 0,
        //             productId: <String>[],
        //             catId: 0,
        //             reelTitle: '',
        //             reelPath: '',
        //             likeStatus: 1,
        //             reelDescription: '',
        //             reelCoverPath: '',
        //             reelHashtag: '',
        //             likesCount: 1,
        //             commentsCount: 1,
        //             product: <ReelProduct>[],
        //             user: UserModel())),
        //   ),
        // ),
        );
  }
}
