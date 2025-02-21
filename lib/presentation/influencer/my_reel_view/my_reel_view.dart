import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../../../core/app_export.dart';
import '../../../data/blocs/my_reel_bloc/my_reel_bloc.dart';
import '../../../data/services/share.dart';
import '../../reels/ui/reel_screen.dart';

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
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      // ),
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
                      return ReelPlayerWidget(
                        initialIndex: 0,
                        reels: state.reels,
                        isMyReel: true,
                      );
                      //   Stack(
                      //   children: [
                      //     Center(
                      //         child: VideoPlayerScreen(
                      //             url: state.reels[index].reelPath)),
                      //     _buildViewCountWidget(textTheme),
                      //     Align(
                      //         alignment: Alignment.bottomRight,
                      //         child: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             _buildRightControl(
                      //                 index, context, state.reels)
                      //           ],
                      //         )),
                      //     SizedBox(height: 36.h),
                      //     SizedBox(height: 12.h),
                      //   ],
                      // );
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

            ///More Options
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
