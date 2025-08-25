import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import '../controllers/profile_controller.dart';
import '../model/my_reels_model.dart';

class MyReelsView extends StatefulWidget {
  final MyReelsData? initialReel;

  const MyReelsView({super.key, this.initialReel});

  @override
  State<MyReelsView> createState() => _MyReelsViewState();
}

class _MyReelsViewState extends State<MyReelsView> {
  final ProfileController profileController = Get.find<ProfileController>();
  final List<VideoPlayerController> _controllers = [];
  bool isMuted = false;
  bool showControls = true;
  Timer? _hideControlsTimer;
  bool _isControllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _startHideControlsTimer();
  }

  Future<void> _initializeControllers() async {
    _controllers.clear();
    setState(() {
      _isControllersInitialized = false;
    });

    while (profileController.myReelsData.isEmpty &&
        profileController.isLoading.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final reels = widget.initialReel != null
        ? [widget.initialReel!] + profileController.myReelsData
        : profileController.myReelsData;

    if (reels.isNotEmpty) {
      List<Future<void>> initializationFutures = [];
      for (var reel in reels) {
        if (reel.video != null) {
          final controller =
              VideoPlayerController.networkUrl(Uri.parse(reel.video!));
          _controllers.add(controller);
          initializationFutures.add(controller.initialize().then((_) {
            setState(() {});
          }));
        }
      }
      await Future.wait(initializationFutures);
      if (_controllers.isNotEmpty) {
        _controllers.first.play();
      }
      setState(() {
        _isControllersInitialized = true;
      });
    } else if (!profileController.isLoading.value) {
      profileController.fetchMyReels();
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        showControls = false;
      });
    });
  }

  void _resetHideControlsTimer() {
    setState(() {
      showControls = true;
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
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (profileController.myReelsData.isEmpty &&
            widget.initialReel == null) {
          return Center(
              child:
                  Text('No_Reels_Available'.tr)); // Updated to use translation
        }
        if (!_isControllersInitialized ||
            _controllers.length !=
                (widget.initialReel != null
                    ? profileController.myReelsData.length + 1
                    : profileController.myReelsData.length)) {
          return const Center(child: CircularProgressIndicator(color: AppColors.black,));
        }

        final reels = widget.initialReel != null
            ? [widget.initialReel!] + profileController.myReelsData
            : profileController.myReelsData;

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reels.length,
          onPageChanged: (index) {
            for (int i = 0; i < _controllers.length; i++) {
              if (i == index && _controllers[i].value.isInitialized) {
                _controllers[i].play();
              } else {
                _controllers[i].pause();
              }
            }
            _resetHideControlsTimer();
          },
          itemBuilder: (context, index) {
            final controller = _controllers[index];
            return GestureDetector(
              onTap: _resetHideControlsTimer,
              child: Stack(
                children: [
                  Center(
                    child: controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          )
                        : const CircularProgressIndicator(color: AppColors.black,),
                  ),
                  if (showControls)
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
                  if (showControls)
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
                  Positioned(
                    top: 50,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.black38,
                        ),
                        child: Image.asset(
                          AppImages.back,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
