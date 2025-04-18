import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/my_streams/my_streams_bloc.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/live_stream_repository/live_stream_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../../data/blocs/my_reel_bloc/my_reel_bloc.dart';
import '../../../../widgets/play_button.dart';
import '../../../shimmers/loading_grid.dart';
import '../../my_reel_view/my_reel_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) =>
                  ProfileApiBloc(context.read<UserRepository>()),
              child: BlocBuilder<ProfileApiBloc, ProfileApiState>(
                builder: (context, state) {
                  if (state is ProfileApiInitial) {
                    context.read<ProfileApiBloc>().add(FetchProfileApi());
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiLoadingState) {
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiError) {
                    return Text(state.message);
                  } else if (state is ProfileApiLoadedState) {
                    UserModel user = state.userModel;
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(100.h),
                              ),
                              child: CustomImageView(
                                radius: BorderRadius.circular(100.h),
                                width: 68.v,
                                height: 68.v,
                                fit: BoxFit.fill,
                                imagePath: user.profileImg,
                              ),
                            ),
                            SizedBox(width: 4.v),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: textTheme.titleMedium,
                                ),
                                SizedBox(height: 4.v),
                                Text(
                                  '${user.followersCount ?? 0} Followers',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomIconButton(
                                icon: ImageConstant.request,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.connectionsRequestScreen);
                                }),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Live Streams',
                        style: textTheme.titleMedium,
                      ),
                      // Text(
                      //   'View All',
                      //   style: textTheme.bodySmall,
                      // ),
                    ],
                  ),
                  SizedBox(height: 12.v),
                  BlocProvider(
                    create: (context) =>
                        MyStreamsBloc(context.read<LiveStreamRepository>()),
                    child: BlocBuilder<MyStreamsBloc, MyStreamsState>(
                      builder: (context, state) {
                        if (state is MyStreamsInitial) {
                          context.read<MyStreamsBloc>().add(FetchMyStreams());
                        } else if (state is MyStreamsLoading) {
                          return const LoadingListPage();
                        } else if (state is MyStreamsError) {
                          return Center(child: Text(state.message));
                        } else if (state is MyStreamsLoaded) {
                          return Column(
                            children: List.generate(
                              state.streams.length > 3
                                  ? 3
                                  : state.streams.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(bottom: 12.v),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      height: 80.v,
                                      width: 80.h,
                                      radius: BorderRadius.circular(6.h),
                                      imagePath: ImageConstant.productImage,
                                    ),
                                    SizedBox(width: 8.h),
                                    SizedBox(
                                      width: SizeUtils.width - 140.h,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state.streams[index].title,
                                              style: textTheme.titleMedium,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "live in",
                                                style: textTheme.bodySmall,
                                              ),
                                              Text(state.streams[index].time,
                                                  //"04H: 35M: 28S",
                                                  style: textTheme.titleMedium)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
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
                  SizedBox(height: 24.v),
                  // Text(
                  //   'Profile Analytics',
                  //   style: textTheme.titleMedium,
                  // ),
                  // SizedBox(height: 12.v),
                  // SizedBox(
                  //   height: 55.v,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) => Container(
                  //       margin: EdgeInsets.only(right: 20.h),
                  //       width: 144.h,
                  //       decoration: BoxDecoration(color: AppColor.offWhite),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Follower Growth',
                  //             style: textTheme.bodySmall,
                  //           ),
                  //           Text(
                  //             '450',
                  //             style: textTheme.bodySmall!
                  //                 .copyWith(color: AppColor.greenColor),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 24.v),
                  Text(
                    ' Top-Performing Content',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  _postView(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postView(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => MyReelBloc(context.read<ReelRepository>()),
      child: BlocBuilder<MyReelBloc, MyReelState>(
        builder: (context, state) {
          if (state is MyReelInitial) {
            context.read<MyReelBloc>().add(LoadMyReelEvent());
          } else if (state is MyReelLoading) {
            return const LoadingGridScreen();
          } else if (state is MyReelError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MyReelLoaded) {
            return state.reels.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 115.v),
                          CustomImageView(
                            imagePath: ImageConstant.noPostFound,
                            height: 100.v,
                          ),
                          SizedBox(height: 15.v),
                          Text(
                            'No Post Yet',
                            style: textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: state.reels.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5.v,
                        crossAxisSpacing: 5.h,
                        childAspectRatio: 140.h / 269.v,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              height: 201.v,
                              fit: BoxFit.fill,
                              radius: BorderRadius.only(
                                  topRight: Radius.circular(12.h),
                                  topLeft: Radius.circular(12.h)),
                              imagePath: state.reels[index].reelCoverPath,
                            ),
                            PlayButton(
                              isVisible: true,
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) =>
                                      VideoReelPage(initialIndex: index),
                                ))
                                    .then((_) {
                                  context
                                      .read<MyReelBloc>()
                                      .add(LoadMyReelEvent());
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 7.v),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 5.v),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    state.reels[index].likesCount.toString(),
                                    //'52.3K',
                                    style: textTheme.bodySmall,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CustomImageView(
                                    height: 20.v,
                                    width: 20.v,
                                    imagePath: ImageConstant.commentIcon,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    state.reels[index].commentsCount.toString(),
                                    style: textTheme.bodySmall,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CustomImageView(
                                    width: 25.h,
                                    imagePath: ImageConstant.visibilityIcon,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    state.reels[index].viewsCount.toString(),
                                    style: textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            CustomImageView(
                              height: 44.v,
                              width: 44.h,
                              imagePath: ImageConstant.graph,
                            ),
                            SizedBox(width: 2.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Engagement Rate:',
                                      style: textTheme.bodySmall!
                                          .copyWith(fontSize: 10.fSize),
                                    ),
                                    Text(
                                      '${state.reels[index].engagement?.rate}',
                                      style: textTheme.bodySmall!.copyWith(
                                          fontSize: 10.fSize,
                                          color: AppColor.greenColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Account Reach:',
                                      style: textTheme.bodySmall!
                                          .copyWith(fontSize: 10.fSize),
                                    ),
                                    Text(
                                      '${state.reels[index].engagement?.accountReach}',
                                      style: textTheme.bodySmall!.copyWith(
                                          fontSize: 10.fSize,
                                          color: AppColor.greenColor),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text(
                                      'Followers Growth:',
                                      style: textTheme.bodySmall!
                                          .copyWith(fontSize: 10.fSize),
                                    ),
                                    Text(
                                      '${state.reels[index].engagement?.followersGrowth}',
                                      style: textTheme.bodySmall!.copyWith(
                                          fontSize: 10.fSize,
                                          color: AppColor.greenColor),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Engagement Rate:${state.reels[index].engagement?.rate}',
                                //       style: textTheme.bodySmall!
                                //           .copyWith(fontSize: 10.fSize),
                                //     ),
                                //   ],
                                // )
                              ],
                            )
                          ],
                        )
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 5.h),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Visibility(
                        //             visible: state.reels[index].likeStatus == 0,
                        //             replacement: InkWell(
                        //               onTap: () {
                        //                 context.read<MyReelBloc>().add(
                        //                     ToggleMyReelLikeButtonEvent(
                        //                         state.reels[index].id));
                        //               },
                        //               child: const Icon(
                        //                 Icons.favorite,
                        //                 color: Colors.red,
                        //               ),
                        //             ),
                        //             child: CustomImageView(
                        //               margin:
                        //                   EdgeInsets.only(top: 6.v, left: 2.h),
                        //               onTap: () {
                        //                 context.read<MyReelBloc>().add(
                        //                     ToggleMyReelLikeButtonEvent(
                        //                         state.reels[index].id));
                        //               },
                        //               imagePath: ImageConstant.favIcon,
                        //               color: Colors.grey,
                        //             ),
                        //           ),
                        //           SizedBox(height: 8.v),
                        //           Text(
                        //             state.reels[index].likesCount.toString(),
                        //             style: textTheme.bodySmall!.copyWith(
                        //                 fontSize: 12.fSize,
                        //                 color: const Color(0xFF232323),
                        //                 fontWeight: FontWeight.w300),
                        //           )
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           CustomImageView(
                        //             onTap: () {
                        //               Navigator.of(context)
                        //                   .pushNamed(AppRoutes.commentsScreen,
                        //                       arguments: state.reels[index].id)
                        //                   .then((_) {
                        //                 context
                        //                     .read<MyReelBloc>()
                        //                     .add(LoadMyReelEvent());
                        //               });
                        //               // showModalBottomSheet(
                        //               //   context: context,
                        //               //   isScrollControlled: true,
                        //               //   builder: (context) => BlocProvider(
                        //               //     create: (context) => CommentsBloc(
                        //               //         context.read<CommentsRepository>()),
                        //               //     child: SizedBox(
                        //               //       height: SizeUtils.height * 0.8,
                        //               //       child: CommentsScreen(
                        //               //           reelId: state.reels[index].id),
                        //               //     ),
                        //               //   ),
                        //               // ).then(
                        //               //   (value) {
                        //               //     context
                        //               //         .read<MyReelBloc>()
                        //               //         .add(LoadMyReelEvent());
                        //               //   },
                        //               // );
                        //             },
                        //             imagePath: ImageConstant.commentIcon,
                        //             color: Colors.grey,
                        //           ),
                        //           SizedBox(height: 8.v),
                        //           Text(
                        //             state.reels[index].commentsCount.toString(),
                        //             style: textTheme.bodySmall!.copyWith(
                        //                 fontSize: 12.fSize,
                        //                 color: const Color(0xFF232323),
                        //                 fontWeight: FontWeight.w300),
                        //           )
                        //         ],
                        //       ),
                        //       InkWell(
                        //         onTap: () async {
                        //           await shareContent(
                        //               state.reels[index].reelPath);
                        //         },
                        //         child: Column(
                        //           children: [
                        //             CustomImageView(
                        //               imagePath: ImageConstant.shareIcon,
                        //               color: Colors.grey,
                        //             ),
                        //             SizedBox(height: 8.v),
                        //             Text(
                        //               'Share',
                        //               style: textTheme.bodySmall!.copyWith(
                        //                   fontSize: 12.fSize,
                        //                   color: const Color(0xFF232323),
                        //                   fontWeight: FontWeight.w300),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                        //
                      ],
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
