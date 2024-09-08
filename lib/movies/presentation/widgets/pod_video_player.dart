import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/colors.dart' as colors;
import 'package:pod_player/pod_player.dart';
import 'package:sizer/sizer.dart';

import '../../domain/models/movie_videos_model.dart';

class YoutubePodPlayer extends StatefulWidget {
  const YoutubePodPlayer({super.key, required this.movieVideo});
  final MovieVideo movieVideo;
  @override
  State<YoutubePodPlayer> createState() => _YoutubePodPlayerState();
}

class _YoutubePodPlayerState extends State<YoutubePodPlayer> {
  late PodPlayerController controller;
  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
            'https://www.youtube.com/watch?v=${widget.movieVideo.key}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [1080, 720, 360]))
      ..initialise();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dragPosition = 0;

    return GestureDetector(
      onTap: () => controller.isInitialised ? Navigator.pop(context) : () {},
      child: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.transparent,
              Color.fromARGB(110, 8, 8, 29),
              Color.fromARGB(178, 8, 8, 29),
              Color.fromARGB(218, 8, 8, 29),
              colors.primaryDark,
              colors.primaryDark,
              colors.primaryDark,
              colors.primaryDark,
              Color.fromARGB(218, 8, 8, 29),
              Color.fromARGB(178, 8, 8, 29),
              Color.fromARGB(110, 8, 8, 29),
              Colors.transparent
            ])),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.sp),
          child: Container(
            padding: EdgeInsets.only(bottom: 10.sp),
            width: 100.w,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: GestureDetector(
                onLongPress: () {
                  controller.enableFullScreen();
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    dragPosition += details.delta.dy;
                  });
                },
                onVerticalDragEnd: (details) {
                  if (dragPosition < 0) {
                    controller.enableFullScreen();
                  }

                  dragPosition = 0;
                },
                child: PodVideoPlayer(
                  videoTitle: Padding(
                    padding: EdgeInsets.only(left: 8.sp, top: 8.sp),
                    child: Text(
                      widget.movieVideo.name,
                      style: GoogleFonts.roboto(
                          color: colors.primarySilver,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  controller: controller,
                  onToggleFullScreen: (isFullScreen) async {
                    if (isFullScreen) {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                      ]);
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                    }
                  },
                  alwaysShowProgressBar: false,
                  podProgressBarConfig: PodProgressBarConfig(
                      padding: EdgeInsets.all(8.sp),
                      circleHandlerRadius: 0.sp,
                      height: 6.sp,
                      bufferedBarColor: colors.primarySilver,
                      backgroundColor: colors.primaryGrey,
                      playingBarColor: colors.primaryBlue,
                      circleHandlerColor: colors.primaryBlue),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
