import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/models/user/user_model.dart';

import '../../../widgets/influencer_card_widget.dart';

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
      body: GridView.custom(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.h),
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
          childCount: imagesList.length,
          (context, index) => InfluencerCardWidget(
              //Need to change here
              reel: Reel(
                  id: 0,
                  userId: 0,
                  productId: <String>[],
                  catId: 0,
                  reelTitle: '',
                  reelPath: '',
                  likeStatus: 1,
                  reelDescription: '',
                  reelCoverPath: '',
                  reelHashtag: '',
                  likesCount: 1,
                  commentsCount: 1,
                  product: <ReelProduct>[],
                  user: UserModel())),
        ),
      ),
    );
  }
}
