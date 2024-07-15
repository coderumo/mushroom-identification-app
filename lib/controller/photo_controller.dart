import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/pages/home_page.dart';
import 'package:tez_front/pages/navigation_tab/home_tab.dart';

class PhotoController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  final _picker = ImagePicker();

  final RxBool isCameraReady = false.obs;

  Future<File?> openCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      print(pickedFile);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        isCameraReady.value = true;
        this.image.value = image;
        return image;
      } else {
        print('No image selected.');
      }
      return null;
    } catch (e) {
      print('Error opening camera: $e');
      return null;
    }
  }

  void cancel() {
    Get.offAll(const HomePage());
  }

  Future<File?> pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      return image.value;
    }
    return null;
  }

  Future<void> loadInitialImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
