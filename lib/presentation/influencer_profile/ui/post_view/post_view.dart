import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';
import 'package:laiza/data/models/reels_model/reel.dart';

import '../../../../widgets/play_button.dart';
import '../../../reels/ui/reel_screen.dart';

class PostView extends StatelessWidget {
  final List<Reel> reel;

  const PostView({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return reel.isEmpty
        ? Center(
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
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.v),
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
              // SizedBox(height: 24.v),
              // Text(
              //   'Trending Post',
              //   style: textTheme.titleMedium,
              // ),
              // SizedBox(height: 12.v),
              // SizedBox(
              //   height: 261.v,
              //   child: ListView.builder(
              //       itemCount: reel.length,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         Post post = Post(
              //             id: reel[index].id,
              //             url: reel[index].reelCoverPath,
              //             isVideo: true);
              //
              //         return Padding(
              //           padding: EdgeInsets.only(right: 24.h),
              //           child: SizedBox(
              //             width: 185.h,
              //             child: Stack(
              //               alignment: Alignment.center,
              //               children: [
              //                 CustomImageView(
              //                   height: 261.v,
              //                   width: 185.h,
              //                   fit: BoxFit.fill,
              //                   radius: BorderRadius.circular(6.h),
              //                   imagePath: post.url,
              //                 ),
              //                 PlayButton(
              //                   isVisible: post.isVideo,
              //                   onTap: () {
              //                     Navigator.of(context).push(MaterialPageRoute(
              //                       builder: (context) => ReelPlayerWidget(
              //                         reels: reel,
              //                         initialIndex: index,
              //                       ),
              //                     ));
              //                   },
              //                 )
              //               ],
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              // SizedBox(height: 36.v),
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
              // SizedBox(height: 24.v),
              // Text(
              //   'Recent Posts',
              //   style: textTheme.titleMedium,
              // ),
              // SizedBox(height: 4.v),
              // Text(
              //   '398 Posts',
              //   style: textTheme.bodySmall,
              // ),
              // SizedBox(height: 15.h),
              GridView.builder(
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
                      5 / 6,
                      crossAxisRatio: 0.9,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                itemCount: reel.length,
                itemBuilder: (context, index) {
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
                            builder: (context) => ReelPlayerWidget(
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
              // SizedBox(height: 24.v),
            ],
          );
  }
}
