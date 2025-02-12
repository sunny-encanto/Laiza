import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';
import 'package:laiza/data/models/reels_model/reel.dart';

import '../../../../data/repositories/reel_repository/reel_repository.dart';
import '../../../../data/services/share.dart';
import '../../../../widgets/like_button/bloc/like_button_bloc.dart';
import '../../../../widgets/play_button.dart';
import '../../../influencer/my_reel_view/my_reel_view.dart';

class PostView extends StatelessWidget {
  final List<Reel> reel;

  const PostView({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 24.v),
        // Row(
        //   children: [
        //     Expanded(
        //       child: CustomTextFormField(
        //         prefixConstraints: BoxConstraints(maxWidth: 25.h),
        //         prefix: Padding(
        //           padding: EdgeInsets.only(left: 10.h),
        //           child: CustomImageView(
        //             width: 15.h,
        //             imagePath: ImageConstant.searchIcon,
        //           ),
        //         ),
        //         hintText: 'Search for  398 Post',
        //       ),
        //     ),
        //     SizedBox(width: 16.h),
        //     CustomIconButton(
        //       icon: ImageConstant.menuIcon,
        //       onTap: () {},
        //     ),
        //   ],
        // ),
        SizedBox(height: 24.v),
        Text(
          'Trending Post',
          style: textTheme.titleMedium,
        ),
        SizedBox(height: 12.v),
        SizedBox(
          height: 261.v,
          child: ListView.builder(
              itemCount: reel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Post post = Post(
                    id: reel[index].id,
                    url: reel[index].reelCoverPath,
                    isVideo: true);

                return Padding(
                  padding: EdgeInsets.only(right: 24.h),
                  child: SizedBox(
                    width: 185.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          height: 261.v,
                          width: 185.h,
                          fit: BoxFit.fill,
                          radius: BorderRadius.circular(6.h),
                          imagePath: post.url,
                        ),
                        PlayButton(
                          isVisible: post.isVideo,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  VideoReelPageOtherInfluencer(
                                reels: reel,
                                initialIndex: index,
                              ),
                            ));
                          },
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 36.v),
        // Text(
        //   'Collections',
        //   style: textTheme.titleMedium,
        // ),
        // SizedBox(height: 8.v),
        // SizedBox(
        //   height: 185.v,
        //   child: ListView.builder(
        //     itemCount: imagesList.length,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) => _buildCollectionCard(context),
        //   ),
        // ),
        SizedBox(height: 24.v),
        Text(
          'Recent Posts',
          style: textTheme.titleMedium,
        ),
        SizedBox(height: 4.v),
        Text(
          '398 Posts',
          style: textTheme.bodySmall,
        ),
        SizedBox(height: 15.h),
        GridView.custom(
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
            childCount: reel.length,
            (context, index) {
              Post post = Post(
                  id: reel[index].id,
                  url: reel[index].reelCoverPath,
                  isVideo: true);
              return Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    height: 261.v,
                    width: 185.h,
                    fit: BoxFit.fill,
                    radius: BorderRadius.circular(6.h),
                    imagePath: post.url,
                  ),
                  PlayButton(
                    isVisible: post.isVideo,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoReelPageOtherInfluencer(
                          reels: reel,
                          initialIndex: index,
                        ),
                      ));
                    },
                  )
                ],
              );
            },
          ),
        ),
        SizedBox(height: 24.v),
      ],
    );
  }
}

class VideoReelPageOtherInfluencer extends StatefulWidget {
  final List<Reel> reels;
  final int initialIndex;

  const VideoReelPageOtherInfluencer(
      {super.key, required this.initialIndex, required this.reels});

  @override
  State<VideoReelPageOtherInfluencer> createState() =>
      _VideoReelPageOtherInfluencer();
}

class _VideoReelPageOtherInfluencer
    extends State<VideoReelPageOtherInfluencer> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isLiked = false;

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
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemCount: widget.reels.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Center(
                    child: ReelVideoPlayerWidget(
                        videoUrl: widget.reels[index].reelPath)),
                _buildViewCountWidget(textTheme),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildRightControl(index, context, widget.reels)
                      ],
                    )),
                SizedBox(height: 36.h),
                SizedBox(height: 12.h),
              ],
            );
          },
        ));
  }

  Align _buildRightControl(int index, BuildContext context, List<Reel> reel) {
    _isLiked = reel[index].likeStatus == 1;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 5.h, bottom: SizeUtils.height * 0.1),
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
            //Comment button
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
            //Share button
            CustomIconButton(
                icon: ImageConstant.share__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () async {
                  await shareContent(reel[index].reelPath);
                }),
            SizedBox(height: 24.h),
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
}
