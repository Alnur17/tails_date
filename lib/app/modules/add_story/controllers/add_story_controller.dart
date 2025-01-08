
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryController extends GetxController {
  RxString selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  // Method to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }
}
