import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/controller/post_controller.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/widgets/custom_button.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final PostController postController = Get.put(PostController());
  final descriptionController = TextEditingController();
  final specieController = TextEditingController();
  String city = '';
  String district = '';
  double latitude = 0.0;
  double longitude = 0.0;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // void _sharePost() {
  //   if (_image != null &&
  //       descriptionController.text.isNotEmpty &&
  //       specieController.text.isNotEmpty &&
  //       city.isNotEmpty &&
  //       district.isNotEmpty) {
  //     final newPost = PostModel(
  //       description: descriptionController.text,
  //       specie: specieController.text,
  //       city: city,
  //       district: district,
  //       latitude: latitude,
  //       longitude: longitude,
  //       file: _image!,
  //     );
  //     postController.uploadPost(newPost);
  //   } else {
  //     Get.snackbar('Error', 'Please fill all the fields');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            CustomButton(
              onPressed: _pickImage,
              buttonText: 'Fotoğraf seç',
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            TextField(
              controller: specieController,
              decoration: const InputDecoration(labelText: 'Mantar Türü'),
            ),
            const SizedBox(height: 10),
            Text('City: $city'),
            Text('District: $district'),
            CustomButton(
              onPressed: () async {
                var location = await Get.to(() => const MapPage());
                if (location != null) {
                  setState(() {
                    city = location['city'];
                    district = location['district'];
                    latitude = location['latitude'];
                    longitude = location['longitude'];
                  });
                }
              },
              buttonText: 'Konum İşaretle',
            ),
            Obx(() {
              return postController.isLoading.value
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {},
                      buttonText: 'Paylaş',
                    );
            }),
          ],
        ),
      ),
    );
  }
}
