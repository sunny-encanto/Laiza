import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/following_bloc/following_bloc.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';

import '../../../data/blocs/all_influencer_bloc/bloc/all_influencer_bloc.dart';
import '../../../widgets/influencer_profile_card_widget.dart';
import '../../shimmers/loading_grid.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Following',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.h),
          child: Column(
            children: [
              BlocProvider(
                create: (context) =>
                    FollowingBloc(context.read<FollowersRepository>()),
                child: BlocBuilder<FollowingBloc, FollowingState>(
                  builder: (context, state) {
                    if (state is FollowingInitial) {
                      context.read<FollowingBloc>().add(FetchFollowings());
                    } else if (state is FollowingLoading) {
                      return const LoadingGridScreen();
                    } else if (state is FollowingErrorState) {
                      return Center(child: Text(state.message));
                    } else if (state is FollowingLoadedState) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.followings.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 165.h / 140.v,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.h,
                          mainAxisSpacing: 20.v,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.influencerProfileScreen,
                                arguments: state.followings[index].followedId
                                    .toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.h),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(imagesList[index]))),
                            height: 120.v,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: 82.v,
                                  width: SizeUtils.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: AppColor.offWhite),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.h),
                                          topRight: Radius.circular(4.h))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 15.v),
                                      Text(
                                        state.followings[index].name,
                                        style: textTheme.titleMedium,
                                      ),
                                      SizedBox(height: 4.v),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.groupIcon),
                                          SizedBox(width: 4.v),
                                          Text(
                                            '${state.followings[index].followersCount} Followers',
                                            style: textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 55.v),
                                  child: CustomImageView(
                                    width: 60.v,
                                    height: 60.v,
                                    imagePath:
                                        state.followings[index].profileImg,
                                    radius: BorderRadius.circular(90.h),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(height: 12.v),
              const Divider(),
              SizedBox(height: 14.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Influencer Picks for You',
                    style: textTheme.titleMedium,
                  ),
                  // Text(
                  //   'VIew All',
                  //   style: textTheme.bodySmall,
                  // ),
                ],
              ),
              SizedBox(height: 20.v),
              BlocProvider(
                create: (context) => AllInfluencerBloc(
                    context.read<UserRepository>(),
                    context.read<FollowersRepository>()),
                child: BlocBuilder<AllInfluencerBloc, AllInfluencerState>(
                  builder: (context, state) {
                    if (state is AllInfluencerInitial) {
                      context
                          .read<AllInfluencerBloc>()
                          .add(FetchAllInfluencer());
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
                        itemCount: state.influencers.length,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 5.v,
                        crossAxisSpacing: 5.h,
                        itemBuilder: (context, index) {
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
    );
  }
}
