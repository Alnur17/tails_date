import 'package:flutter/material.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import '../controllers/reels_controller.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final List<VideoPlayerController> _controllers = [];
  late bool isMuted;
  bool showControls = true;
  Timer? _hideControlsTimer;
  final ReelsController reelsController = Get.put(ReelsController());
  bool _isControllersInitialized = false;

  @override
  void initState() {
    super.initState();
    isMuted = false;
    _initializeControllers();
    _startHideControlsTimer();
  }

  Future<void> _initializeControllers() async {
    _controllers.clear();
    setState(() {
      _isControllersInitialized = false;
    });

    while (reelsController.reels.isEmpty && reelsController.isLoading.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final reels = reelsController.reels;
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
    } else if (reelsController.errorMessage.value.isEmpty) {
      reelsController.fetchReels();
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
        if (reelsController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.black));
        }
        if (reelsController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(reelsController.errorMessage.value));
        }
        if (reelsController.reels.isEmpty) {
          return Center(child: Text('No_Reels_Available'.tr));
        }
        if (!_isControllersInitialized ||
            _controllers.length != reelsController.reels.length) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.black));
        }
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: reelsController.reels.length,
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
            final reel = reelsController.reels[index];
            final controller = _controllers[index];
            return GestureDetector(
              onTap: _resetHideControlsTimer,
              child: Stack(
                children: [
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
                        _resetHideControlsTimer();
                      },
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    )
                        : const CircularProgressIndicator(),
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
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 30, left: 20, right: 60),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.black.withOpacity(0.6),
                            AppColors.black.withOpacity(0.05),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: (reel.author?.image != null && reel.author!.image!.isNotEmpty)
                                    ? NetworkImage(reel.author!.image!)
                                    : NetworkImage(AppImages.imageNotAvailable) as ImageProvider,
                              ),

                              sw12,
                              Text(
                                reel.author?.name ?? 'Unknown'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          sh8,
                          Text(
                            reel.caption ?? 'No_Description'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (reel.id != null) {
                              reelsController.toggleLike(reel.id!);
                            }
                          },
                          child: Container(
                            height: 30,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.black38,
                            ),
                            child: Image.asset(
                              reelsController.isReelsLiked(reel.id ?? '')
                                  ? AppImages.heartFilled
                                  : AppImages.heart,
                              scale: 4,
                              color: reelsController.isReelsLiked(reel.id ?? '')
                                  ? AppColors.red
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        sh8,
                        Text(
                          reel.reactions.length.toString(),
                          style: h5.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
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