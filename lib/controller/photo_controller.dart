import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  final _picker = ImagePicker();

  final RxBool isCameraReady = false.obs;

  Future<void> openCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
        isCameraReady.value = true;
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error opening camera: $e');
    }
  }

  void saveImage() {
    // Fotoğrafı kaydetme işlemi
  }

  void cancel() {
    return Get.back();
  }

  void saveAndShareImage() {
    // Fotoğrafı kaydetme ve paylaşma işlemi
  }

  Future<void> pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
