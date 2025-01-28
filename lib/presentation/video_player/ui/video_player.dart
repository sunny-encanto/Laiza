// import 'package:video_player/video_player.dart';
//
// import '../../../core/app_export.dart';
// import '../bloc/video_player_bloc.dart';
//
// class VideoPlayerWidget extends StatelessWidget {
//   final String videoUrl;
//
//   const VideoPlayerWidget({super.key, required this.videoUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocProvider(
//         create: (context) => VideoPlayerBloc(videoUrl),
//         child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
//           builder: (context, state) {
//             if (state is VideoPlayerLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is VideoPlayerReady) {
//               return Stack(
//                 children: [
//                   Center(
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: state.controller.value.aspectRatio,
//                           child: VideoPlayer(state.controller),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             state.controller.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.transparent,
//                             size: 30,
//                           ),
//                           onPressed: () {
//                             if (state.controller.value.isPlaying) {
//                               context
//                                   .read<VideoPlayerBloc>()
//                                   .add(VideoPlayerPause());
//                             } else {
//                               context
//                                   .read<VideoPlayerBloc>()
//                                   .add(VideoPlayerPlay());
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return const Center(child: Text("Something went wrong"));
//           },
//         ),
//       ),
//     );
//   }
// }
