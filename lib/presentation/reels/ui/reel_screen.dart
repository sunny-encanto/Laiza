import 'package:laiza/data/models/reels_model/reels_model.dart';
import 'package:laiza/presentation/reels/bloc/reel_bloc.dart';
import 'package:laiza/widgets/slider_widget.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

import '../../../core/app_export.dart';
import '../../../data/services/share.dart';
import '../../../widgets/like_button/bloc/like_button_bloc.dart';

class ReelScreen extends StatelessWidget {
  ReelScreen({super.key});
  bool _isFollowed = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ReelBloc(),
        child: Column(
          children: [
            Expanded(
              child: WhiteCodelReels(
                  key: UniqueKey(),
                  context: context,
                  loader: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  isCaching: true,
                  videoList: List.generate(
                      realList.length, (index) => realList[index].url),
                  builder: (context, index, child, videoPlayerController,
                      pageController) {
                    pageController.addListener(() {
                      if (pageController.page != index.toDouble()) {
                        videoPlayerController.pause();
                      } else {
                        videoPlayerController.play();
                      }
                    });
                    return Stack(
                      children: [
                        child,
                        _buildViewCountWidget(textTheme),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildRightControl(index, context),
                              SizedBox(height: 54.v),
                              customSlider(
                                height: 100.h,
                                childList: [_buildSliderItem(context)],
                              ),
                              SizedBox(height: 36.h),
                              _buildFollowBanner(context),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildRightControl(int index, BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Like button
            BlocProvider(
              create: (context) => LikeButtonBloc(),
              child: BlocBuilder<LikeButtonBloc, LikeButtonState>(
                buildWhen: (previous, current) =>
                    current is LikeButtonPressState,
                builder: (context, state) {
                  if (state is LikeButtonPressState) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)),
                      child: IconButton(
                          onPressed: () {
                            context
                                .read<LikeButtonBloc>()
                                .add(LikeButtonPressEvent(!state.isLIked));
                          },
                          icon: Icon(
                            state.isLIked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: state.isLIked ? Colors.red : Colors.white,
                          )),
                    );
                  }
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () {
                          context.read<LikeButtonBloc>().add(
                              LikeButtonPressEvent(
                                  !realList[index].likeStatus));
                        },
                        icon: Icon(
                          realList[index].likeStatus
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: realList[index].likeStatus
                              ? Colors.red
                              : Colors.white,
                        )),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            //Comment button
            CustomIconButton(
                icon: ImageConstant.commentIcon,
                color: Colors.black,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => CommentsBloc(),
                      child: const CommentsScreen(),
                    ),
                  );
                }),
            SizedBox(height: 24.h),
            //Share button
            CustomIconButton(
                icon: ImageConstant.shareIcon,
                color: Colors.black,
                onTap: () async {
                  await shareContent(realList[index].url);
                }),
            SizedBox(height: 24.h),
            //Wish list button
            CustomIconButton(
              icon: ImageConstant.bookIcon,
              color: Colors.black,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Align _buildViewCountWidget(TextTheme textTheme) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(left: 5.h, top: 80.v),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.h),
            color: Colors.black.withOpacity(.65)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.visibility_outlined,
              color: Colors.white,
              size: 15.h,
            ),
            SizedBox(width: 3.h),
            Text(
              '7.5k Views',
              style: textTheme.bodySmall!.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSliderItem(BuildContext context) {
    return Container(
      width: SizeUtils.width - 60.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.h)),
      child: Row(
        children: [
          CustomImageView(
            radius: BorderRadius.only(
                topLeft: Radius.circular(12.h),
                bottomLeft: Radius.circular(12.h)),
            width: 100.h,
            height: 100.v,
            fit: BoxFit.fill,
            imagePath: ImageConstant.shoeImg,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('₹ 2582'),
                  SizedBox(height: 5.h),
                  const Text(
                    'OGIY RETRO SHOES HIGH PREMIUM QUALITY Sneakers For Men',
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.h),
                  const Text(
                    'Stock:2',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.productDetailScreen);
            },
            child: Container(
              margin: EdgeInsets.all(5.h),
              width: 36.h,
              height: 91.h,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.h)),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 15.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildFollowBanner(BuildContext context) {
    return Container(
      width: SizeUtils.width,
      height: 56.h,
      decoration: const BoxDecoration(color: Colors.black),
      child: Row(
        children: [
          SizedBox(width: 20.h),
          CustomImageView(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.influencerProfileScreen);
            },
            height: 40.h,
            width: 40.h,
            radius: BorderRadius.circular(20.h),
            imagePath: ImageConstant.reelImg,
          ),
          SizedBox(width: 12.h),
          Text(
            'Daniel George',
            style: TextStyle(color: Colors.white, fontSize: 16.fSize),
          ),
          SizedBox(width: 20.h),
          BlocConsumer<ReelBloc, ReelState>(
            listener: (context, state) {
              if (state is ReelFollowRequestState) {
                _isFollowed = state.isFollowed;
              }
            },
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  context
                      .read<ReelBloc>()
                      .add(ReelFollowRequestEvent(!_isFollowed));
                },
                child: Row(
                  children: [
                    Container(
                      height: 8.v,
                      width: 8.v,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      _isFollowed ? 'Following' : 'Follow',
                      style: TextStyle(color: Colors.white, fontSize: 16.fSize),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class ReelScreen extends StatelessWidget {
//   ReelScreen({super.key});
//   bool _isFollowed = false;
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: BlocProvider(
//           create: (context) => ReelBloc()..add(LoadReels(reelUrl)),
//           child: PageView.builder(
//               onPageChanged: (index) {
//                 context.read<ReelBloc>().add(ChangeReelPage(index));
//               },
//               itemCount: reelUrl.length,
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index) => Stack(
//                     children: [
//                       BlocBuilder<ReelBloc, ReelState>(
//                         builder: (context, state) {
//                           if (state is ReelLoading) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }
//                           if (state is ReelLoaded) {
//                             return Center(
//                               child: AspectRatio(
//                                 aspectRatio:
//                                     state.videoController.value.aspectRatio,
//                                 child: VideoPlayer(state.videoController),
//                               ),
//                             );
//                           }
//                           return const SizedBox.shrink();
//                         },
//                       ),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                 margin: EdgeInsets.only(left: 5.h),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 10.h, vertical: 5.v),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.h),
//                                     color: Colors.black.withOpacity(.65)),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.visibility_outlined,
//                                       color: Colors.white,
//                                       size: 15.h,
//                                     ),
//                                     SizedBox(width: 3.h),
//                                     Text(
//                                       '7.5k Views',
//                                       style: textTheme.bodySmall!
//                                           .copyWith(color: Colors.white),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 5.h),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     //Like button
//                                     BlocProvider(
//                                       create: (context) => LikeButtonBloc(),
//                                       child: BlocBuilder<LikeButtonBloc,
//                                           LikeButtonState>(
//                                         builder: (context, state) {
//                                           if (state is LikeButtonPressState) {
//                                             return Container(
//                                               decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12)),
//                                               child: IconButton(
//                                                   onPressed: () {
//                                                     context
//                                                         .read<LikeButtonBloc>()
//                                                         .add(
//                                                             LikeButtonPressEvent(
//                                                                 !state
//                                                                     .isLIked));
//                                                   },
//                                                   icon: Icon(
//                                                     state.isLIked
//                                                         ? Icons.favorite
//                                                         : Icons
//                                                             .favorite_border_outlined,
//                                                     color: state.isLIked
//                                                         ? Colors.red
//                                                         : Colors.white,
//                                                   )),
//                                             );
//                                           }
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12)),
//                                             child: IconButton(
//                                                 onPressed: () {
//                                                   context
//                                                       .read<LikeButtonBloc>()
//                                                       .add(LikeButtonPressEvent(
//                                                           !realList[index]
//                                                               .likeStatus));
//                                                 },
//                                                 icon: Icon(
//                                                   realList[index].likeStatus
//                                                       ? Icons.favorite
//                                                       : Icons
//                                                           .favorite_border_outlined,
//                                                   color:
//                                                       realList[index].likeStatus
//                                                           ? Colors.red
//                                                           : Colors.white,
//                                                 )),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 24.h),
//                                     //Comment button
//                                     CustomIconButton(
//                                         icon: ImageConstant.commentIcon,
//                                         color: Colors.black,
//                                         onTap: () {}),
//                                     SizedBox(height: 24.h),
//                                     //Share button
//                                     CustomIconButton(
//                                         icon: ImageConstant.shareIcon,
//                                         color: Colors.black,
//                                         onTap: () async {
//                                           await shareContent(
//                                               realList[index].url);
//                                         }),
//                                     SizedBox(height: 24.h),
//                                     //Wish list button
//                                     CustomIconButton(
//                                         icon: ImageConstant.bookIcon,
//                                         color: Colors.black,
//                                         onTap: () {}),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 54.v),
//                             customSlider(
//                                 height: 100.h,
//                                 childList: [_buildSliderItem(context)]),
//                             SizedBox(height: 36.h),
//                             _buildFollowBanner(context),
//                             SizedBox(height: 12.h),
//                           ],
//                         ),
//                       )
//                     ],
//                   ))),
//     );
//   }

//   Widget _buildSliderItem(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.only(left: 20.h),
//       width: SizeUtils.width - 60.h,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(12.h)),
//       child: Row(
//         children: [
//           CustomImageView(
//             radius: BorderRadius.only(
//                 topLeft: Radius.circular(12.h),
//                 bottomLeft: Radius.circular(12.h)),
//             width: 100.h,
//             height: 100.v,
//             fit: BoxFit.fill,
//             imagePath: ImageConstant.shoeImg,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(5.0.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('₹ 2582'),
//                   SizedBox(height: 5.h),
//                   const Text(
//                     'OGIY RETRO SHOES HIGH PREMIUM QUALITY Sneakers For Men',
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 3.h),
//                   const Text(
//                     'Stock:2',
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.of(context).pushNamed(AppRoutes.productDetailScreen);
//             },
//             child: Container(
//               margin: EdgeInsets.all(5.h),
//               width: 36.h,
//               height: 91.h,
//               decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(12.h)),
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.white,
//                 size: 15.h,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container _buildFollowBanner(BuildContext context) {
//     return Container(
//       width: SizeUtils.width,
//       height: 56.h,
//       decoration: const BoxDecoration(color: Colors.black),
//       child: Row(
//         children: [
//           SizedBox(width: 20.h),
//           CustomImageView(
//             onTap: () {
//               Navigator.of(context)
//                   .pushNamed(AppRoutes.influencerProfileScreen);
//             },
//             height: 40.h,
//             width: 40.h,
//             radius: BorderRadius.circular(20.h),
//             imagePath: ImageConstant.reelImg,
//           ),
//           SizedBox(width: 12.h),
//           Text(
//             'Daniel George',
//             style: TextStyle(color: Colors.white, fontSize: 16.fSize),
//           ),
//           SizedBox(width: 20.h),
//           BlocConsumer<ReelBloc, ReelState>(
//             listener: (context, state) {
//               if (state is ReelFollowRequestState) {
//                 _isFollowed = state.isFollowed;
//               }
//             },
//             builder: (context, state) {
//               return InkWell(
//                 onTap: () {
//                   context
//                       .read<ReelBloc>()
//                       .add(ReelFollowRequestEvent(!_isFollowed));
//                 },
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 10.v,
//                       width: 10.v,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.white),
//                     ),
//                     SizedBox(width: 5.h),
//                     Text(
//                       _isFollowed ? 'Following' : 'Follow',
//                       style: TextStyle(color: Colors.white, fontSize: 16.fSize),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
