import 'dart:io';

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
