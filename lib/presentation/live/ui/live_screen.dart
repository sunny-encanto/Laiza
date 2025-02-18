import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/upcoming_stream_bloc/up_coming_stream_bloc.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';
import 'package:laiza/data/repositories/live_stream_repository/live_stream_repository.dart';
import 'package:laiza/data/services/firebase_services.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../data/blocs/following_bloc/following_bloc.dart';
import '../../../data/models/followers_model/follower.dart';
import '../../../data/repositories/follow_repository/follow_repository.dart';
import '../../../widgets/streams_card_widget.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Followed Influencer',
                style: textTheme.titleLarge,
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
                          width: 114.h, height: 114.v);
                    } else if (state is FollowingLoading) {
                      return HorizontalLoadingListPage(
                          width: 114.h, height: 114.v);
                    } else if (state is FollowingErrorState) {
                      return Center(child: Text(state.message));
                    } else if (state is FollowingLoadedState) {
                      return SizedBox(
                          height: 114.v,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.followings.length,
                              itemBuilder: (context, index) {
                                Follower following = state.followings[index];
                                return Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: profileWidget(context, following),
                                );
                              }));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getOnGoingLiveStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return HorizontalLoadingListPage(
                          width: 185.h, height: 250.v);
                    } else if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    }
                    var snapShotData = snapshot.data?.docs ?? [];
                    List<LiveStreamModel> liveStreamModel = snapShotData
                        .map((e) => LiveStreamModel.fromMap(
                            e.data() as Map<String, dynamic>))
                        .toList();
                    return liveStreamModel.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 28.v),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ongoing Streams',
                                    style: textTheme.titleLarge,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.allOngoingStreamsScreen);
                                    },
                                    child: Text(
                                      'View All',
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 28.v),
                              SizedBox(
                                height:
                                    liveStreamModel.isNotEmpty ? 250.v : 0.v,
                                child: ListView.builder(
                                  itemCount: liveStreamModel.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(right: 10.h),
                                    child: StreamsCard(
                                      isLive: true,
                                      model: liveStreamModel[index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  }),
              SizedBox(height: 36.v),
              Text(
                'Upcoming Streams',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 20.v),
              BlocProvider(
                create: (context) =>
                    UpComingStreamBloc(context.read<LiveStreamRepository>()),
                child: BlocBuilder<UpComingStreamBloc, UpComingStreamState>(
                  builder: (context, state) {
                    if (state is UpComingStreamInitial) {
                      context
                          .read<UpComingStreamBloc>()
                          .add(FetchUpcomingStream());
                      return HorizontalLoadingListPage(
                          width: 185.h, height: 250.v);
                    } else if (state is UpComingStreamLoading) {
                      return HorizontalLoadingListPage(
                          width: 185.h, height: 250.v);
                    } else if (state is UpComingStreamLoaded) {
                      List<LiveStreamModel> liveStreamModel =
                          state.upcomingStreams
                              .map((e) => LiveStreamModel(
                                    liveId: e.id.toString(),
                                    userName: e.users.name ?? '',
                                    userId: e.users.id,
                                    userProfile: e.users.profileImg,
                                  ))
                              .toList();
                      return SizedBox(
                        height: liveStreamModel.isNotEmpty ? 250.v : 0.v,
                        child: ListView.builder(
                          itemCount: liveStreamModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(right: 10.h),
                            child: StreamsCard(
                              isLive: false,
                              model: liveStreamModel[index],
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // _buildUpComingStreamCardGreen() {
  //   return CustomImageView(
  //     margin: EdgeInsets.symmetric(horizontal: 2.h),
  //     radius: BorderRadius.circular(12.h),
  //     imagePath: ImageConstant.sliderImageGreen,
  //   );
  // }
  //
  // _buildUpComingStreamCardRed() {
  //   return CustomImageView(
  //     margin: EdgeInsets.symmetric(horizontal: 2.h),
  //     radius: BorderRadius.circular(12.h),
  //     imagePath: ImageConstant.sliderImageRed,
  //   );
  // }

  Widget profileWidget(BuildContext context, Follower following) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Outer colored border
              Container(
                width: 82.h,
                height: 82.v,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              // Inner content
              Container(
                width: 75.v,
                height: 75.v,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CustomImageView(
                  radius: BorderRadius.circular(82.h),
                  width: 82.h,
                  height: 82.v,
                  imagePath: following.profileImg,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: -5.v,
                child: Container(
                  width: 42.h,
                  height: 19.v,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFF4365),
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Text(
                    'Live',
                    style: TextStyle(color: Colors.white, fontSize: 12.fSize),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            following.name,
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
