import 'package:laiza/core/app_export.dart';

import '../data/models/reels_model/reel.dart';

class InfluencerCardWidget extends StatelessWidget {
  final Reel reel;

  const InfluencerCardWidget({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
            arguments: reel.user.id);
      },
      child: Container(
        width: 185.h,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                // fit: BoxFit.fill,
                image: NetworkImage(reel.reelCoverPath)),
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.h)),
        child: Padding(
          padding: EdgeInsets.all(0.0.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.h),
                  bottomRight: Radius.circular(12.h)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0x39393900).withOpacity(0),
                  const Color(0xFF111111),
                ],
                // stops: const [0.7083, 0.9717],
              ),
            ),
            child: Row(
              children: [
                CustomImageView(
                  height: 30.v,
                  width: 30.v,
                  radius: BorderRadius.circular(20.h),
                  imagePath: reel.user.profileImg,
                  // fit: BoxFit.fitHeight,
                ),
                SizedBox(width: 5.h),
                Text(
                  reel.user.name ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.fSize,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
