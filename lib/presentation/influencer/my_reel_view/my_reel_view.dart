import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../core/app_export.dart';
import '../../../data/blocs/my_reel_bloc/my_reel_bloc.dart';
import '../../../data/services/share.dart';
import '../../../widgets/play_button.dart';

class VideoReelPage extends StatefulWidget {
  final int initialIndex;

  const VideoReelPage({super.key, required this.initialIndex});

  @override
  State<VideoReelPage> createState() => _VideoReelPageState();
}

class _VideoReelPageState extends State<VideoReelPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: BlocProvider(
          create: (context) => MyReelBloc(context.read<ReelRepository>()),
          child: BlocConsumer<MyReelBloc, MyReelState>(
              listener: (context, state) {
                if (state is MyReelDeleteSuccess) {
                  Navigator.of(context).pop();
                  context.showSnackBar(state.message);
                } else if (state is MyReelDeleteError) {
                  context.showSnackBar(state.message);
                }
              },
              buildWhen: (previous, current) => current is MyReelLoaded,
              builder: (context, state) {
                if (state is MyReelInitial) {
                  context.read<MyReelBloc>().add(LoadMyReelEvent());
                } else if (state is MyReelLoading) {
                  return const SizedBox.shrink();
                } else if (state is MyReelError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is MyReelLoaded) {
                  return PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: state.reels.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Center(
                              child: VideoPlayerWidget(
                                  videoUrl: state.reels[index].reelPath)),
                          _buildViewCountWidget(textTheme),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildRightControl(
                                      index, context, state.reels)
                                ],
                              )),
                          SizedBox(height: 36.h),
                          SizedBox(height: 12.h),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              })),
    );
  }

  Align _buildRightControl(int index, BuildContext context, List<Reel> reel) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 5.h, bottom: SizeUtils.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Like button
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                  onPressed: () {
                    context
                        .read<MyReelBloc>()
                        .add(ToggleMyReelLikeButtonEvent(reel[index].id));
                  },
                  icon: Icon(
                    reel[index].likeStatus == 1
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color:
                        reel[index].likeStatus == 1 ? Colors.red : Colors.white,
                  )),
            ),

            SizedBox(height: 24.h),
            //Comment button
            CustomIconButton(
                icon: ImageConstant.commnet__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.commentsScreen,
                          arguments: reel[index].id)
                      .then((_) {
                    context.read<MyReelBloc>().add(LoadMyReelEvent());
                  });
                }),
            SizedBox(height: 24.h),
            //Share button
            CustomIconButton(
                icon: ImageConstant.share__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () async {
                  await shareContent(reel[index].reelPath);
                }),
            SizedBox(height: 24.h),
            //Wish list button
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
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true) // Enable looping
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _controller.value.isInitialized
            ? SizedBox(
                height: SizeUtils.height,
                width: SizeUtils.width,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: SizeUtils.height * _controller.value.aspectRatio,
                    height: SizeUtils.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        _controller.value.isPlaying
            ? InkWell(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: SizedBox(
                  height: 50.h,
                  width: 50.v,
                ),
              )
            : PlayButton(
                isVisible: true,
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
              )
        // Positioned(
        //   top: -50.v,
        //   left: 2.h,
        //   child: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),
      ],
    );
  }
}

//
// class MyReelViewScreen extends StatelessWidget {
//   final int reelId;
//
//   MyReelViewScreen({super.key, required this.reelId});
//
//   bool _isScrolled = false;
//   bool _isLiked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: BlocProvider(
//           create: (context) => MyReelBloc(context.read<ReelRepository>()),
//           child: BlocConsumer<MyReelBloc, MyReelState>(
//               listener: (context, state) {
//                 if (state is MyReelDeleteSuccess) {
//                   Navigator.of(context).pop();
//                   context.showSnackBar(state.message);
//                 } else if (state is MyReelDeleteError) {
//                   context.showSnackBar(state.message);
//                 }
//               },
//               buildWhen: (previous, current) => current is MyReelLoaded,
//               builder: (context, state) {
//                 if (state is MyReelInitial) {
//                   context.read<MyReelBloc>().add(LoadMyReelEvent());
//                 } else if (state is MyReelLoading) {
//                   return const SizedBox.shrink();
//                 } else if (state is MyReelError) {
//                   return Center(
//                     child: Text(state.message),
//                   );
//                 } else if (state is MyReelLoaded) {
//                   return Column(
//                     children: [
//                       state.reels.isNotEmpty
//                           ? Expanded(
//                               child: WhiteCodelReels(
//                                   key: UniqueKey(),
//                                   context: context,
//                                   loader: const Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                   isCaching: true,
//                                   videoList: List.generate(state.reels.length,
//                                       (index) => state.reels[index].reelPath),
//                                   builder: (context, index, child,
//                                       videoPlayerController, pageController) {
//                                     pageController.addListener(() {
//                                       if (pageController.page !=
//                                           index.toDouble()) {
//                                         videoPlayerController.pause();
//                                       } else {
//                                         videoPlayerController.play();
//                                       }
//                                     });
//
//                                     if (!_isScrolled) {
//                                       print('ReedId=>$reelId');
//                                       int initialIndex = state.reels.indexWhere(
//                                           (reel) => reel.id == reelId);
//                                       pageController.animateToPage(initialIndex,
//                                           duration:
//                                               const Duration(milliseconds: 1),
//                                           curve: Curves.ease);
//                                       if (index == initialIndex) {
//                                         _isScrolled = true;
//                                       }
//                                     }
//                                     _isLiked =
//                                         state.reels[index].likeStatus == 1;
//                                     return Stack(
//                                       children: [
//                                         child,
//                                         _buildViewCountWidget(textTheme),
//                                         Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               _buildRightControl(
//                                                   index, context, state),
//                                               SizedBox(height: 36.h),
//                                               SizedBox(height: 12.h),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     );
//                                   }),
//                             )
//                           : const SizedBox.shrink(),
//                     ],
//                   );
//                 }
//                 return const SizedBox.shrink();
//               })),
//     );
//   }
//
//   Align _buildRightControl(
//       int index, BuildContext context, MyReelLoaded state) {
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Padding(
//         padding: EdgeInsets.only(right: 5.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             //Like button
//             BlocProvider(
//               create: (context) =>
//                   LikeButtonBloc(context.read<ReelRepository>()),
//               child: BlocBuilder<LikeButtonBloc, LikeButtonState>(
//                 buildWhen: (previous, current) =>
//                     current is LikeButtonPressState,
//                 builder: (context, likeButtonState) {
//                   if (likeButtonState is LikeButtonPressState) {
//                     _isLiked = likeButtonState.isLIked;
//                     return Container(
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: IconButton(
//                           onPressed: () {
//                             context.read<LikeButtonBloc>().add(
//                                 LikeButtonPressEvent(
//                                     isLiked: !_isLiked,
//                                     reelId: state.reels[index].id));
//                           },
//                           icon: Icon(
//                             _isLiked
//                                 ? Icons.favorite
//                                 : Icons.favorite_border_outlined,
//                             color: _isLiked ? Colors.red : Colors.white,
//                           )),
//                     );
//                   }
//                   return Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: IconButton(
//                         onPressed: () {
//                           context.read<LikeButtonBloc>().add(
//                               LikeButtonPressEvent(
//                                   isLiked: !_isLiked,
//                                   reelId: state.reels[index].id));
//                         },
//                         icon: Icon(
//                           _isLiked
//                               ? Icons.favorite
//                               : Icons.favorite_border_outlined,
//                           color: _isLiked ? Colors.red : Colors.white,
//                         )),
//                   );
//                 },
//               ),
//             ),
//
//             SizedBox(height: 24.h),
//             //Comment button
//             CustomIconButton(
//                 icon: ImageConstant.commnet__,
//                 color: Colors.black,
//                 iconColor: Colors.white,
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (context) => BlocProvider(
//                       create: (context) =>
//                           CommentsBloc(context.read<CommentsRepository>()),
//                       child: SizedBox(
//                         height: SizeUtils.height * 0.8,
//                         child: CommentsScreen(reelId: state.reels[index].id),
//                       ),
//                     ),
//                   );
//                 }),
//             SizedBox(height: 24.h),
//             //Share button
//             CustomIconButton(
//                 icon: ImageConstant.share__,
//                 color: Colors.black,
//                 iconColor: Colors.white,
//                 onTap: () async {
//                   await shareContent(state.reels[index].reelPath);
//                 }),
//             SizedBox(height: 24.h),
//             //Wish list button
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (mContext) =>
//                       _buildMoreUi(context, state.reels[index]),
//                 );
//               },
//               child: Container(
//                 height: 50.h,
//                 width: 50.h,
//                 decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: const Icon(
//                   Icons.more_vert,
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Align _buildViewCountWidget(TextTheme textTheme) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Container(
//         margin: EdgeInsets.only(left: 5.h, top: 80.v),
//         padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.h),
//             color: Colors.black.withOpacity(.65)),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.visibility_outlined,
//               color: Colors.white,
//               size: 15.h,
//             ),
//             SizedBox(width: 3.h),
//             Text(
//               '7.5k Views',
//               style: textTheme.bodySmall!.copyWith(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   _buildMoreUi(BuildContext context, Reel reel) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextButton.icon(
//               style: TextButton.styleFrom(
//                   alignment: Alignment.centerLeft,
//                   minimumSize: Size(SizeUtils.width, 50.v)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed(AppRoutes.uploadReelScreen,
//                     arguments: {'path': '', 'reel': reel});
//               },
//               icon: const Icon(Icons.edit, color: Colors.black),
//               label: const Text('Edit', style: TextStyle(color: Colors.black)),
//             ),
//             Divider(color: AppColor.primary),
//             TextButton.icon(
//               style: TextButton.styleFrom(
//                   alignment: Alignment.centerLeft,
//                   minimumSize: Size(SizeUtils.width, 50.v)),
//               onPressed: () {
//                 context.read<MyReelBloc>().add(MyReelDeleteEvent(reel.id));
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(Icons.delete, color: Colors.red),
//               label: const Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
