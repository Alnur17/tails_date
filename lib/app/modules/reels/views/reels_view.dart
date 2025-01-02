import 'package:flutter/material.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final List<Map<String, dynamic>> videoUrls = [
    {
      "title": "Sample Title 1",
      "video":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    },
    {
      "title": "Sample Title 2",
      "video":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    },
    {
      "title": "Sample Title 3",
      "video":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    },
  ];

  final List<VideoPlayerController> _controllers = [];
  late bool isMuted;

  @override
  void initState() {
    super.initState();
    isMuted = false;
    for (var item in videoUrls) {
      _controllers
          .add(VideoPlayerController.networkUrl(Uri.parse(item['video']))
            ..initialize().then((_) {
              setState(() {});
            }));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        onPageChanged: (index) {
          // Automatically play the video on the current page and pause others
          for (int i = 0; i < _controllers.length; i++) {
            if (i == index) {
              _controllers[i].play();
            } else {
              _controllers[i].pause();
            }
          }
        },
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          final videoData = videoUrls[index];

          return Stack(
            children: [
              // Video player or loader
              Center(
                child: controller.value.isInitialized
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          });
                        },
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : const CircularProgressIndicator(), // Loader
              ),
              // Center play/pause button
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                  child: Image.asset(
                    controller.value.isPlaying
                        ? AppImages.pause
                        : AppImages.play,
                    color: Colors.white,
                    scale: 4,
                  ),
                ),
              ),

              // Mute/Unmute button in the top-right corner
              Positioned(
                top: 50,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMuted = !isMuted;
                      controller.setVolume(isMuted ? 0 : 1);
                    });
                  },
                  child: Container(
                    height: 30,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.black38,
                    ),
                    child: Image.asset(
                      isMuted ? AppImages.mute : AppImages.unMute,
                      color: Colors.white,
                      scale: 4,
                    ),
                  ),
                ),
              ),

              // Video Title and Controls
              Positioned(
                bottom: 50,
                left: 20,
                child: Text(
                  videoData['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 20,
                child: Column(
                  children: [
                    Image.asset(AppImages.heart, scale: 4, color: Colors.white),
                    sh8,
                    Text(
                      '15',
                      style: h5.copyWith(color: AppColors.white),
                    ),
                    sh16,
                    Image.asset(AppImages.bookmark,
                        scale: 4, color: Colors.white),
                    sh16,
                    Image.asset(AppImages.share, scale: 4, color: Colors.white),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
