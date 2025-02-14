// import 'package:laiza/core/app_export.dart';
// import 'package:laiza/data/models/reels_model/reel.dart';
//
// import '../data/services/share.dart';
// import '../presentation/influencer/my_reel_view/my_reel_view.dart';
//
// class SingleReelWidget extends StatelessWidget {
//   final Reel reel;
//   final Function(int) onLike;
//
//   const SingleReelWidget({super.key, required this.reel, required this.onLike});
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Material(
//       child: Stack(
//         children: [
//           Center(
//             child: ReelVideoPlayerWidget(videoUrl: reel.reelPath),
//           ),
//           _buildViewCountWidget(textTheme),
//           Align(
//               alignment: Alignment.bottomRight,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [_buildRightControl(context, reel)],
//               )),
//           SizedBox(height: 36.h),
//           SizedBox(height: 12.h),
//         ],
//       ),
//     );
//   }
//
//   Align _buildRightControl(BuildContext context, Reel reel) {
//     bool isLiked = reel.likeStatus == 1;
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Padding(
//         padding: EdgeInsets.only(right: 5.h, bottom: SizeUtils.height * 0.1),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             //Like button
//             // BlocProvider(
//             //   create: (context) =>
//             //       LikeButtonBloc(context.read<ReelRepository>()),
//             //   child: BlocBuilder<LikeButtonBloc, LikeButtonState>(
//             //     buildWhen: (previous, current) =>
//             //         current is LikeButtonPressState,
//             //     builder: (context, state) {
//             //       if (state is LikeButtonPressState) {
//             //         return Container(
//             //           decoration: BoxDecoration(
//             //               color: Colors.black,
//             //               borderRadius: BorderRadius.circular(12)),
//             //           child: IconButton(
//             //               onPressed: () {
//             //                 isLiked = !isLiked;
//             //                 onLike(reel.id);
//             //                 // context.read<LikeButtonBloc>().add(
//             //                 //     LikeButtonPressEvent(
//             //                 //         reelId: reel.id, isLiked: isLiked));
//             //               },
//             //               icon: Icon(
//             //                 state.isLIked
//             //                     ? Icons.favorite
//             //                     : Icons.favorite_border_outlined,
//             //                 color: state.isLIked ? Colors.red : Colors.white,
//             //               )),
//             //         );
//             //       }
//             //       return Container(
//             //         decoration: BoxDecoration(
//             //             color: Colors.black,
//             //             borderRadius: BorderRadius.circular(12)),
//             //         child: IconButton(
//             //             onPressed: () {
//             //               isLiked = !isLiked;
//             //
//             //               context.read<LikeButtonBloc>().add(
//             //                   LikeButtonPressEvent(
//             //                       reelId: reel.id, isLiked: isLiked));
//             //             },
//             //             icon: Icon(
//             //               isLiked
//             //                   ? Icons.favorite
//             //                   : Icons.favorite_border_outlined,
//             //               color: isLiked ? Colors.red : Colors.white,
//             //             )),
//             //       );
//             //     },
//             //   ),
//             // ),
//
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.black, borderRadius: BorderRadius.circular(12)),
//               child: IconButton(
//                   onPressed: () {
//                     onLike(reel.id);
//                     // context
//                     //     .read<MyReelBloc>()
//                     //     .add(ToggleMyReelLikeButtonEvent(reel[index].id));
//                   },
//                   icon: Icon(
//                     reel.id == 1
//                         ? Icons.favorite
//                         : Icons.favorite_border_outlined,
//                     color: reel.id == 1 ? Colors.red : Colors.white,
//                   )),
//             ),
//
//             SizedBox(height: 24.h),
//             //Comment button
//             CustomIconButton(
//                 icon: ImageConstant.commnet__,
//                 color: Colors.black,
//                 iconColor: Colors.white,
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushNamed(AppRoutes.commentsScreen, arguments: reel.id)
//                       .then((_) {
//                     //context.read<MyReelBloc>().add(LoadMyReelEvent());
//                   });
//                 }),
//             SizedBox(height: 24.h),
//             //Share button
//             CustomIconButton(
//                 icon: ImageConstant.share__,
//                 color: Colors.black,
//                 iconColor: Colors.white,
//                 onTap: () async {
//                   await shareContent(reel.reelPath);
//                 }),
//             SizedBox(height: 24.h),
//             //Wish list button
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
// }
