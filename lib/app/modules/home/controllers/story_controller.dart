import 'dart:async';
import 'package:get/get.dart';

class StoryController extends GetxController {
  final currentIndex = 0.obs;
  final progress = 0.0.obs;

  Timer? _timer;

  late final List<String> storyImageUrls;

  //
  // StoryController(this.storyImageUrls);

  @override
  void onInit() {
    super.onInit();
    _startProgress();
  }

  void _startProgress() {
    progress.value = 0.0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress.value < 1.0) {
        progress.value += 0.01; // Adjust this value to control speed
      } else {
        //goToNextStory(currentIndex);
        _timer?.cancel();
      }
    });
  }

  void goToNextStory(storyImageUrls) {
    if (currentIndex.value < storyImageUrls.length - 1) {
      currentIndex.value++;
      _startProgress();
    } else {
      Get.back();
    }
  }

  void goToPreviousStory() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      _startProgress();
    } else {
      Get.back();
    }
  }

  void resetProgress() {
    _timer?.cancel();
    _startProgress();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
