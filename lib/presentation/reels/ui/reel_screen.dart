import 'dart:async';

import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/reels/bloc/reel_bloc.dart';

import '../../../core/app_export.dart';
import '../../../data/blocs/my_reel_bloc/my_reel_bloc.dart';
import '../../../data/models/reels_model/reel.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/services/share.dart';
import '../../../widgets/like_button/bloc/like_button_bloc.dart';
import '../../../widgets/slider_widget.dart';
import '../../user/video_player/ui/video_player.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: BlocProvider(
          create: (context) => ReelBloc(context.read<ReelRepository>()),
          child: BlocBuilder<ReelBloc, ReelState>(
              buildWhen: (previous, current) => (current is ReelLoading ||
                  current is ReelLoaded ||
                  current is ReelError),
              builder: (context, state) {
                if (state is ReelInitial) {
                  context.read<ReelBloc>().add(LoadReelEvent());
                } else if (state is ReelLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReelError) {
                  return Center(child: Text(state.message));
                } else if (state is ReelLoaded) {
                  return state.reels.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome To Laiza',
                                style: textTheme.titleSmall!
                                    .copyWith(fontSize: 20.fSize),
                              ),
                              SizedBox(height: 20.v),
                              CustomImageView(
                                  height: 120,
                                  imagePath: ImageConstant.noPostFound),
                              SizedBox(height: 20.v),
                              Text('No Reels Found',
                                  style: textTheme.titleSmall),
                            ],
                          ),
                        )
                      : ReelPlayerWidget(reels: state.reels, initialIndex: 0);
                  // return
                  //   PageView.builder(
                  //     itemCount: state.reels.length,
                  //     scrollDirection: Axis.vertical,
                  //     itemBuilder: (context, index) => Stack(
                  //           children: [
                  //             ReelVideoPlayerWidget(
                  //               videoUrl: state.reels[index].reelPath,
                  //             ),
                  //             // _buildViewCountWidget(textTheme),
                  //             Align(
                  //               alignment: Alignment.bottomRight,
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   _buildRightControl(
                  //                       state.reels[index], context),
                  //                   SizedBox(height: 54.v),
                  //                   customSlider(
                  //                     height: 100.h,
                  //                     autoPlay:
                  //                         state.reels[index].product.length > 1,
                  //                     childList: List.generate(
                  //                       state.reels[index].product.length,
                  //                       (sliderIndex) => _buildSliderItem(
                  //                           context,
                  //                           state.reels[index]
                  //                               .product[sliderIndex]),
                  //                     ),
                  //                   ),
                  //                   SizedBox(height: 36.h),
                  //                   if (state.reels[index].user.userType !=
                  //                       'seller')
                  //                     _buildFollowBanner(
                  //                         context, state.reels[index].user),
                  //                   SizedBox(height: 12.h),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ));
                  // return Column(
                  //   children: [
                  //     state.reels.isNotEmpty
                  //         ? Expanded(
                  //             child: WhiteCodelReels(
                  //                 key: UniqueKey(),
                  //                 context: context,
                  //                 loader: const Center(
                  //                   child: CircularProgressIndicator(),
                  //                 ),
                  //                 isCaching: true,
                  //                 videoList: List.generate(state.reels.length,
                  //                     (index) => state.reels[index].reelPath),
                  //                 builder: (context, index, child,
                  //                     videoPlayerController, pageController) {
                  //                   pageController.addListener(() {
                  //                     if (pageController.page !=
                  //                         index.toDouble()) {
                  //                       videoPlayerController.pause();
                  //                     } else {
                  //                       videoPlayerController.play();
                  //                     }
                  //                   });
                  //                   _isLiked =
                  //                       state.reels[index].likeStatus == 1;
                  //                   return Stack(
                  //                     children: [
                  //                       child,
                  //                       //TODO: Need to uncomment
                  //                       // _buildViewCountWidget(textTheme),
                  //                       Align(
                  //                         alignment: Alignment.bottomRight,
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             _buildRightControl(
                  //                                 state.reels[index], context),
                  //                             SizedBox(height: 54.v),
                  //                             customSlider(
                  //                               height: 100.h,
                  //                               autoPlay: state.reels[index]
                  //                                       .product.length >
                  //                                   1,
                  //                               childList: List.generate(
                  //                                 state.reels[index].product
                  //                                     .length,
                  //                                 (sliderIndex) =>
                  //                                     _buildSliderItem(
                  //                                         context,
                  //                                         state.reels[index]
                  //                                                 .product[
                  //                                             sliderIndex]),
                  //                               ),
                  //                             ),
                  //                             SizedBox(height: 36.h),
                  //                             if (state.reels[index].user
                  //                                     .userType !=
                  //                                 'seller')
                  //                               _buildFollowBanner(context,
                  //                                   state.reels[index].user),
                  //                             SizedBox(height: 12.h),
                  //                           ],
                  //                         ),
                  //                       )
                  //                     ],
                  //                   );
                  //                 }),
                  //           )
                  //         : const SizedBox.shrink(),
                  //   ],
                  // );
                }
                return const SizedBox.shrink();
              })),
    );
  }

// Align _buildRightControl(Reel reel, BuildContext context) {
//   return Align(
//     alignment: Alignment.bottomRight,
//     child: Padding(
//       padding: EdgeInsets.only(right: 5.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           //Like button
//           BlocProvider(
//             create: (context) =>
//                 LikeButtonBloc(context.read<ReelRepository>()),
//             child: BlocBuilder<LikeButtonBloc, LikeButtonState>(
//               buildWhen: (previous, current) =>
//                   current is LikeButtonPressState,
//               builder: (context, state) {
//                 if (state is LikeButtonPressState) {
//                   return Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: IconButton(
//                         onPressed: () {
//                           _isLiked = !_isLiked;
//
//                           context.read<LikeButtonBloc>().add(
//                               LikeButtonPressEvent(
//                                   reelId: reel.id, isLiked: _isLiked));
//                         },
//                         icon: Icon(
//                           state.isLIked
//                               ? Icons.favorite
//                               : Icons.favorite_border_outlined,
//                           color: state.isLIked ? Colors.red : Colors.white,
//                         )),
//                   );
//                 }
//                 return Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(12)),
//                   child: IconButton(
//                       onPressed: () {
//                         _isLiked = !_isLiked;
//
//                         context.read<LikeButtonBloc>().add(
//                             LikeButtonPressEvent(
//                                 reelId: reel.id, isLiked: _isLiked));
//                       },
//                       icon: Icon(
//                         _isLiked
//                             ? Icons.favorite
//                             : Icons.favorite_border_outlined,
//                         color: _isLiked ? Colors.red : Colors.white,
//                       )),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 24.h),
//           //Comment button
//           CustomIconButton(
//               icon: ImageConstant.commnet__,
//               color: Colors.black,
//               iconColor: Colors.white,
//               onTap: () {
//                 Navigator.of(context)
//                     .pushNamed(AppRoutes.commentsScreen, arguments: reel.id)
//                     .then((_) {
//                   context.read<MyReelBloc>().add(LoadMyReelEvent());
//                 });
//               }),
//           SizedBox(height: 24.h),
//           //Share button
//           CustomIconButton(
//               icon: ImageConstant.share__,
//               color: Colors.black,
//               onTap: () async {
//                 await shareContent(reel.reelPath);
//               }),
//           SizedBox(height: 24.h),
//           //Wish list button
//           CustomIconButton(
//             icon: ImageConstant.bookIcon,
//             color: Colors.black,
//             onTap: () {},
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// Align _buildViewCountWidget(TextTheme textTheme) {
//   return Align(
//     alignment: Alignment.topLeft,
//     child: Container(
//       margin: EdgeInsets.only(left: 5.h, top: 80.v),
//       padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.h),
//           color: Colors.black.withOpacity(.65)),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.visibility_outlined,
//             color: Colors.white,
//             size: 15.h,
//           ),
//           SizedBox(width: 3.h),
//           Text(
//             '7.5k Views',
//             style: textTheme.bodySmall!.copyWith(color: Colors.white),
//           )
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _buildSliderItem(BuildContext context, ReelProduct product) {
//   return Container(
//     width: SizeUtils.width - 60.h,
//     decoration: BoxDecoration(
//         color: Colors.white, borderRadius: BorderRadius.circular(12.h)),
//     child: Row(
//       children: [
//         CustomImageView(
//           radius: BorderRadius.only(
//               topLeft: Radius.circular(12.h),
//               bottomLeft: Radius.circular(12.h)),
//           width: 100.h,
//           height: 100.v,
//           fit: BoxFit.fill,
//           imagePath: product.productImage,
//         ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.all(5.0.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '₹ ${product.price}',
//                   style: TextStyle(fontSize: 15.fSize),
//                 ),
//                 SizedBox(height: 5.h),
//                 Text(
//                   product.productName,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 3.h),
//                 // const Text(
//                 //   'Stock:2',
//                 //   overflow: TextOverflow.ellipsis,
//                 // ),
//               ],
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.of(context).pushNamed(AppRoutes.productDetailScreen,
//                 arguments: product.id);
//           },
//           child: Container(
//             margin: EdgeInsets.all(5.h),
//             width: 36.h,
//             height: 91.h,
//             decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(12.h)),
//             child: Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.white,
//               size: 15.h,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Container _buildFollowBanner(BuildContext context, UserModel user) {
//   return Container(
//     width: SizeUtils.width,
//     height: 56.h,
//     decoration: const BoxDecoration(color: Colors.black),
//     child: Row(
//       children: [
//         SizedBox(width: 20.h),
//         CustomImageView(
//           onTap: () {
//             Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
//                 arguments: user.id ?? '');
//           },
//           height: 40.h,
//           width: 40.h,
//           radius: BorderRadius.circular(20.h),
//           imagePath: user.profileImg,
//           fit: BoxFit.fill,
//         ),
//         SizedBox(width: 12.h),
//         Text(
//           user.name ?? '',
//           style: TextStyle(color: Colors.white, fontSize: 16.fSize),
//         ),
//         SizedBox(width: 20.h),
//         BlocConsumer<ReelBloc, ReelState>(
//           listener: (context, state) {
//             if (state is ReelFollowRequestState) {
//               _isFollowed = state.isFollowed;
//             }
//           },
//           builder: (context, state) {
//             return InkWell(
//               onTap: () {
//                 context
//                     .read<ReelBloc>()
//                     .add(ReelFollowRequestEvent(!_isFollowed));
//               },
//               child: Row(
//                 children: [
//                   Container(
//                     height: 8.v,
//                     width: 8.v,
//                     decoration: const BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.white),
//                   ),
//                   SizedBox(width: 5.h),
//                   Text(
//                     _isFollowed ? 'Following' : 'Follow',
//                     style: TextStyle(color: Colors.white, fontSize: 16.fSize),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     ),
//   );
// }
}

class ReelPlayerWidget extends StatefulWidget {
  final List<Reel> reels;
  final int initialIndex;
  final bool? isMyReel;

  const ReelPlayerWidget(
      {super.key,
      required this.initialIndex,
      required this.reels,
      this.isMyReel});

  @override
  State<ReelPlayerWidget> createState() => _ReelPlayerWidget();
}

class _ReelPlayerWidget extends State<ReelPlayerWidget>
    with WidgetsBindingObserver {
  late PageController _pageController;
  late int _currentIndex;
  bool _isLiked = false;
  bool _isFollowed = false;
  Map<int, Timer> _pageTimers = {}; // Store timers for each page
  Map<int, bool> _viewCounted = {}; // Store timers for each page
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    WidgetsBinding.instance.addObserver(this);

    // Listen to page changes
    _pageController.addListener(() {
      int newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentIndex) {
        _pageTimers[_currentIndex]?.cancel(); // Cancel timer for previous page
        _currentIndex = newPage;
        _startTimerForPage(_currentIndex); // Start timer for new page
      }
    });

    // Start timer for the initial page
    _startTimerForPage(_currentIndex);
  }

  void _startTimerForPage(int pageIndex) {
    print('_startTimerForPage');
    // Initialize view counted status if not already set
    _viewCounted[pageIndex] ??= false;

    // Cancel any existing timer for this page
    _pageTimers[pageIndex]?.cancel();

    // Start a new timer
    _pageTimers[pageIndex] = Timer(const Duration(seconds: 10), () {
      print('_startTimerForPage');
      if (mounted &&
          _currentIndex == pageIndex &&
          _isActive &&
          !_viewCounted[pageIndex]!) {
        _onTenSecondsElapsed(pageIndex);
        _viewCounted[pageIndex] = true; // Mark view as counted
      }
    });
  }

  void _onTenSecondsElapsed(int pageIndex) {
    print('User has been on reel $pageIndex for 10 seconds!');
    // Call the repository to increment view count
    context.read<ReelRepository>().addReelView(widget.reels[pageIndex].id);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isActive = state ==
          AppLifecycleState.resumed; // Pause timer when app is in background
    });
  }

  @override
  void dispose() {
    _pageTimers.forEach((_, timer) => timer.cancel()); // Cancel all timers
    _pageTimers.clear();
    _viewCounted.clear();
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: BlocProvider(
          create: (context) => ReelBloc(context.read<ReelRepository>()),
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.reels.length,
            itemBuilder: (context, index) {
              // return
              //   Column(
              //   children: [
              //     widget.reels.isNotEmpty
              //         ? Expanded(
              //             child: WhiteCodelReels(
              //                 key: UniqueKey(),
              //                 context: context,
              //                 loader: const Center(
              //                   child: CircularProgressIndicator(),
              //                 ),
              //                 isCaching: true,
              //                 videoList: List.generate(widget.reels.length,
              //                     (index) => widget.reels[index].reelPath),
              //                 builder: (context, index, child,
              //                     videoPlayerController, pageController) {
              //                   pageController.addListener(() {
              //                     if (pageController.page != index.toDouble()) {
              //                       videoPlayerController.pause();
              //                     } else {
              //                       videoPlayerController.play();
              //                     }
              //                   });
              //                   _isLiked = widget.reels[index].likeStatus == 1;
              //                   return Stack(
              //                     children: [
              //                       child,
              //                       //TODO: Need to uncomment
              //                       // _buildViewCountWidget(textTheme),
              //                       Align(
              //                         alignment: Alignment.bottomRight,
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.min,
              //                           children: [
              //                             _buildRightControl(
              //                               index,
              //                               context,
              //                               widget.reels,
              //                             ),
              //                             SizedBox(height: 54.v),
              //                             if (widget
              //                                 .reels[index].product.isNotEmpty)
              //                               customSlider(
              //                                 height: 100.h,
              //                                 autoPlay: widget.reels[index]
              //                                         .product.length >
              //                                     1,
              //                                 childList: List.generate(
              //                                   widget.reels[index].product
              //                                       .length,
              //                                   (sliderIndex) =>
              //                                       _buildSliderItem(
              //                                           context,
              //                                           widget.reels[index]
              //                                                   .product[
              //                                               sliderIndex]),
              //                                 ),
              //                               ),
              //                             SizedBox(height: 36.h),
              //                             _buildFollowBanner(context,
              //                                 widget.reels[index].user),
              //                             SizedBox(height: 12.h),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   );
              //                 }),
              //           )
              //         : const SizedBox.shrink(),
              //   ],
              // );
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: VideoPlayerScreen(url: widget.reels[index].reelPath),
                  ),
                  _buildViewCountWidget(widget.reels[index].viewsCount),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Align(
                        //     alignment: Alignment.bottomRight,
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         _buildRightControl(index, context, widget.reels)
                        //       ],
                        //     )),
                        _buildRightControl(index, context, widget.reels),
                        SizedBox(height: 36.h),
                        if (widget.reels[index].product.isNotEmpty)
                          customSlider(
                            height: 100.h,
                            autoPlay: widget.reels[index].product.length > 1,
                            childList: List.generate(
                              widget.reels[index].product.length,
                              (sliderIndex) => _buildSliderItem(context,
                                  widget.reels[index].product[sliderIndex]),
                            ),
                          ),
                        SizedBox(height: 36.h),
                        // if (widget.reels[index].user.userType != 'seller')
                        _buildFollowBanner(context, widget.reels[index].user),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  Align _buildRightControl(int index, BuildContext context, List<Reel> reel) {
    _isLiked = reel[index].likeStatus == 1;
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
              create: (context) =>
                  LikeButtonBloc(context.read<ReelRepository>()),
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
                            _isLiked = !_isLiked;
                            context.read<LikeButtonBloc>().add(
                                LikeButtonPressEvent(
                                    reelId: reel[index].id, isLiked: _isLiked));
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
                          _isLiked = !_isLiked;

                          context.read<LikeButtonBloc>().add(
                              LikeButtonPressEvent(
                                  reelId: reel[index].id, isLiked: _isLiked));
                        },
                        icon: Icon(
                          _isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: _isLiked ? Colors.red : Colors.white,
                        )),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),

            ///Comment button
            CustomIconButton(
                icon: ImageConstant.commnet__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.commentsScreen,
                          arguments: reel[index].id)
                      .then((_) {});
                }),
            SizedBox(height: 24.h),

            ///Share button
            CustomIconButton(
                icon: ImageConstant.share__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () async {
                  await shareContent(reel[index].reelPath);
                }),
            SizedBox(height: 24.h),

            ///More Options
            if (widget.isMyReel ?? false)
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (mContext) => _buildMoreUi(context, reel[index]),
                  );
                },
                child: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  _buildMoreUi(BuildContext context, Reel reel) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(SizeUtils.width, 50.v)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.uploadReelScreen,
                    arguments: {'path': '', 'reel': reel});
              },
              icon: const Icon(Icons.edit, color: Colors.black),
              label: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
            Divider(color: AppColor.primary),
            TextButton.icon(
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(SizeUtils.width, 50.v)),
              onPressed: () {
                context.read<MyReelBloc>().add(MyReelDeleteEvent(reel.id));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildViewCountWidget(int count) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
              '$count Views',
              style: textTheme.bodySmall!.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSliderItem(BuildContext context, ReelProduct product) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.productDetailScreen, arguments: product.id);
      },
      child: Container(
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
              imagePath: product.productImage,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹ ${product.mrp} ',
                          style: textTheme.bodySmall!
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '₹ ${product.price}',
                          style: TextStyle(fontSize: 15.fSize),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      product.productName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Stock: ${product.stock}',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }

  Container _buildFollowBanner(BuildContext context, UserModel user) {
    _isFollowed = user.isFollowed ?? false;
    return Container(
      width: SizeUtils.width,
      height: 56.h,
      color: Colors.black.withOpacity(0.6),
      // decoration: const BoxDecoration(color: Colors.black),
      child: Row(
        children: [
          SizedBox(width: 20.h),
          CustomImageView(
            onTap: () {
              if (user.userType != 'seller') {
                Navigator.of(context).pushNamed(
                    AppRoutes.influencerProfileScreen,
                    arguments: user.id ?? '');
              }
            },
            height: 40.h,
            width: 40.h,
            radius: BorderRadius.circular(20.h),
            imagePath: user.profileImg,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 12.h),
          InkWell(
            onTap: () {
              if (user.userType != 'seller') {
                Navigator.of(context).pushNamed(
                    AppRoutes.influencerProfileScreen,
                    arguments: user.id ?? '');
              }
            },
            child: Text(
              user.userType != 'seller'
                  ? user.name ?? ''
                  : user.brandName ?? user.name,
              style: TextStyle(color: Colors.white, fontSize: 16.fSize),
            ),
          ),
          SizedBox(width: 20.h),
          if (user.userType != 'seller')
            BlocProvider(
              create: (context) => ReelBloc(context.read<ReelRepository>()),
              child: BlocConsumer<ReelBloc, ReelState>(
                listener: (context, state) {
                  if (state is ReelFollowRequestState) {
                    _isFollowed = state.isFollowed;
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<ReelBloc>().add(ReelFollowRequestEvent(
                          isFollowed: !_isFollowed,
                          id: int.parse(user.id ?? '0')));
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 8.v,
                          width: 8.v,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          _isFollowed ? 'Following' : 'Follow',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16.fSize),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
