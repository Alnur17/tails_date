import 'package:flutter/material.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

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
      "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
      "video":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      "description":
          "Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.Descriptions should be display here.",
    },
    {
      "title": "Sample Title 2",
      "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
      "video":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "description": "Descriptions should be display here.",
    },
    {
      "title": "Sample Title 3",
      "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
      "video":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "description": "Descriptions should be display here.",
    },
  ];

  final List<VideoPlayerController> _controllers = [];
  late bool isMuted;
  bool showControls = true;
  Timer? _hideControlsTimer;

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
    _startHideControlsTimer(); // Start the timer to hide controls
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        showControls = false; // Hide controls after 3 seconds
      });
    });
  }

  void _resetHideControlsTimer() {
    setState(() {
      showControls = true; // Show controls when user interacts
    });
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _hideControlsTimer?.cancel();
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
          for (int i = 0; i < _controllers.length; i++) {
            if (i == index) {
              _controllers[i].play();
            } else {
              _controllers[i].pause();
            }
          }
          _resetHideControlsTimer();
        },
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          final videoData = videoUrls[index];

          return GestureDetector(
            onTap: _resetHideControlsTimer, // Reset the timer on tap
            child: Stack(
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
                            _resetHideControlsTimer(); // Show controls on interaction
                          },
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ),
                        )
                      : const CircularProgressIndicator(),
                ),
                // Center play/pause button
                if (showControls) // Conditionally render controls
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
                        _resetHideControlsTimer();
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
                // Mute/Unmute button
                if (showControls) // Conditionally render mute/unmute button
                  Positioned(
                    top: 50,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMuted = !isMuted;
                          controller.setVolume(isMuted ? 0 : 1);
                        });
                        _resetHideControlsTimer();
                      },
                      child: Container(
                        height: 30,
                        decoration: const ShapeDecoration(
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
                  bottom: 65,
                  left: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(videoData['image'],),
                      ),
                      sw12,
                      Text(
                        videoData['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 65,
                  child: Text(
                    videoData['description'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.heart,
                        scale: 4,
                        color: Colors.white,
                      ),
                      sh8,
                      Text(
                        '15',
                        style: h5.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      sh16,
                      Image.asset(
                        AppImages.bookmark,
                        scale: 4,
                        color: Colors.white,
                      ),
                      sh16,
                      Image.asset(
                        AppImages.share,
                        scale: 4,
                        color: Colors.white,
                      ),
                      sh16,
                      Image.asset(
                        AppImages.threeDot,
                        scale: 4,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
