import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/widgets/play_button.dart';

import '../data/models/trending_items_model/trending_items_model.dart';
import '../data/services/share.dart';
import '../presentation/influencer/my_reel_view/my_reel_view.dart';

class TrendingCardWidget extends StatelessWidget {
  final TrendingItems trendingItems;
  final double extent;

  const TrendingCardWidget(
      {super.key, required this.trendingItems, required this.extent});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              if (trendingItems.type == TrendingItemType.PRODUCT) {
                Navigator.of(context).pushNamed(AppRoutes.productDetailScreen,
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
            if (trendingItems.type == TrendingItemType.REEL) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SingleReelWidget(
                  //Need to  change here
                  reel: Reel(
                      id: trendingItems.id,
                      userId: 0,
                      productId: <String>[],
                      catId: 0,
                      reelTitle: '',
                      reelPath: trendingItems.reelPath ?? '',
                      likeStatus: 1,
                      reelDescription: '',
                      reelCoverPath: trendingItems.image,
                      reelHashtag: '',
                      likesCount: 1,
                      commentsCount: 0,
                      product: <ReelProduct>[],
                      user: UserModel()),
                ),
              ));
            }
          },
        )
      ],
    );
  }
}

class SingleReelWidget extends StatelessWidget {
  final Reel reel;

  const SingleReelWidget({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      child: Stack(
        children: [
          Center(
            child: ReelVideoPlayerWidget(videoUrl: reel.reelPath),
          ),
          _buildViewCountWidget(textTheme),
          Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_buildRightControl(context, 1)],
              )),
          SizedBox(height: 36.h),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Align _buildRightControl(BuildContext context, int id) {
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
                    // context
                    //     .read<MyReelBloc>()
                    //     .add(ToggleMyReelLikeButtonEvent(reel[index].id));
                  },
                  icon: Icon(
                    reel.id == 1
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: reel.id == 1 ? Colors.red : Colors.white,
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
                      .pushNamed(AppRoutes.commentsScreen, arguments: reel.id)
                      .then((_) {
                    //context.read<MyReelBloc>().add(LoadMyReelEvent());
                  });
                }),
            SizedBox(height: 24.h),
            //Share button
            CustomIconButton(
                icon: ImageConstant.share__,
                color: Colors.black,
                iconColor: Colors.white,
                onTap: () async {
                  await shareContent(reel.reelPath);
                }),
            SizedBox(height: 24.h),
            //Wish list button
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
