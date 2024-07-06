import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/controller/post_controller.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:tez_front/widgets/custom_button.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  SharePageState createState() => SharePageState();
}

class SharePageState extends State<SharePage> {
  final descriptionController = TextEditingController();
  final specieController = TextEditingController();
  String konum = '';
  double latitude = 0.0;
  double longitude = 0.0;
  File? _image;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
                : SizedBox(
                    height: 400,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
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
            Text('Konum: $konum'),
            CustomButton(
              onPressed: () async {
                final location = await Get.to(() => const MapPage());
                print(location);
                if (location != null) {
                  setState(() {
                    konum =
                        "${location['city'] ?? ''}${location['city'] != null ? ',' : ''}${location['district'] ?? ''}";
                    latitude = location['latitude'];
                    longitude = location['longitude'];
                  });
                }
              },
              buttonText: 'Konum İşaretle',
            ),
            CustomButton(
              onPressed: () async {
                final requestModel = PostRequestModel(
                  description: descriptionController.text,
                  specie: specieController.text,
                  place: konum,
                  latitude: latitude.toString(),
                  longitude: longitude.toString(),
                );

                try {
                  setState(() {
                    isLoading = true;
                  });
                  AuthService authService = AuthService();
                  final res =
                      await authService.createPost(requestModel, _image!);
                  if (res.success) {
                    Get.snackbar('Success', 'Post created successfully');
                  } else {
                    Get.snackbar('Error', res.message);
                  }
                  setState(() {
                    isLoading = false;
                  });

                  Get.back();
                } catch (e) {
                  Get.snackbar('Error', e.toString());
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              buttonText: 'Paylaş',
            )
          ],
        ),
      ),
    );
  }
}
