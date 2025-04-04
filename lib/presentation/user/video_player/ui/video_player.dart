import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/app_export.dart';
import '../../../../widgets/play_button.dart';
import '../../../video_player/bloc/video_player_bloc.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: BlocProvider(
        create: (context) => VideoPlayerBloc(videoUrl),
        child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoPlayerReady) {
              return Stack(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: state.controller.value.aspectRatio,
                          child: VideoPlayer(state.controller),
                        ),
                        IconButton(
                          icon: Icon(
                            state.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.transparent,
                            size: 30,
                          ),
                          onPressed: () {
                            if (state.controller.value.isPlaying) {
                              context
                                  .read<VideoPlayerBloc>()
                                  .add(VideoPlayerPause());
                            } else {
                              context
                                  .read<VideoPlayerBloc>()
                                  .add(VideoPlayerPlay());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text("Something went wrong"));
          },
        ),
      ),
    );
  }
}

class VideoPlayerFromFile extends StatefulWidget {
  final String path;

  const VideoPlayerFromFile({super.key, required this.path});

  @override
  State<VideoPlayerFromFile> createState() => _VideoPlayerFromFileState();
}

class _VideoPlayerFromFileState extends State<VideoPlayerFromFile> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Provide the path to your local video file here
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown before the video starts
        setState(() {});
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
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.h),
              bottomLeft: Radius.circular(12.h)),
          child: Center(
            child: _controller.value.isInitialized
                ? SizedBox(
                    height: 470.v,
                    width: SizeUtils.width,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
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
      ],
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;
  String? _errorMessage;

  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _setupPlayer();
  }

  // void _setupPlayer() {
  //   print('URL=> ${widget.url}');
  //   try {
  //     _controller = VideoPlayerController.network(widget.url)
  //       ..setLooping(true) // Enable looping
  //       ..initialize().then((_) {
  //         setState(() {});
  //         _controller.play();
  //       });
  //   } catch (e) {
  //     debugPrint("Video Error=> ${e.toString()}");
  //   }
  // }

  void _setupPlayer() {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      // cacheConfiguration: const BetterPlayerCacheConfiguration(
      //   useCache: true,
      //   // Enable caching
      //   preCacheSize: 10 * 1024 * 1024,
      //   // Pre-cache 10 MB of video
      //   maxCacheSize: 100 * 1024 * 1024,
      //   // Max cache size: 100 MB
      // ),
    );

    // Configure the player
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      allowedScreenSleep: false,
      looping: true,
      autoPlay: true,
      fit: BoxFit.contain,
      // aspectRatio: 9 / 16,
      aspectRatio: 9 / 20,
      errorBuilder: (context, errorMessage) {
        if (mounted) {
          setState(() {
            _errorMessage = errorMessage;
          });
        }
        return const Center(
          child: SizedBox(
              // "Error: $errorMessage",
              // style: const TextStyle(color: Colors.red),
              ),
        );
      },
      controlsConfiguration: const BetterPlayerControlsConfiguration(
        showControls: true,
        enablePlayPause: true,
        enableMute: false,
        enableFullscreen: false,
        enableProgressBar: false,
        enableProgressText: false,
        enableSkips: false,
        enableOverflowMenu: false,
        enablePlaybackSpeed: false,
        showControlsOnInitialize: false,
      ),
    );
    _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: dataSource,
    );
    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
        print("Player Exception: ${event.parameters}");
      }
    });
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _errorMessage != null
        ? Center(child: Text(_errorMessage!))
        : BetterPlayer(controller: _betterPlayerController);
    // return
    //     //VideoPlayerScreen(url: widget.videoUrl);
    //     Stack(
    //   clipBehavior: Clip.none,
    //   alignment: Alignment.center,
    //   children: [
    //     _controller.value.isInitialized
    //         ? SizedBox(
    //             height: SizeUtils.height,
    //             width: SizeUtils.width,
    //             child: FittedBox(
    //               fit: BoxFit.cover,
    //               child: SizedBox(
    //                 width: SizeUtils.height * _controller.value.aspectRatio,
    //                 height: SizeUtils.height,
    //                 child: VideoPlayer(_controller),
    //               ),
    //             ),
    //           )
    //         : const Center(child: CircularProgressIndicator()),
    //     _controller.value.isPlaying
    //         ? InkWell(
    //             onTap: () {
    //               setState(() {
    //                 if (_controller.value.isPlaying) {
    //                   _controller.pause();
    //                 } else {
    //                   _controller.play();
    //                 }
    //               });
    //             },
    //             child: SizedBox(
    //               height: 50.h,
    //               width: 50.v,
    //             ),
    //           )
    //         : PlayButton(
    //             isVisible: true,
    //             onTap: () {
    //               setState(() {
    //                 if (_controller.value.isPlaying) {
    //                   _controller.pause();
    //                 } else {
    //                   _controller.play();
    //                 }
    //               });
    //             },
    //           )
    //   ],
    // );
  }
}
