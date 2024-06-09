import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/widgets/app_bar_custom.dart';
import 'package:tez_front/widgets/custom_button.dart';
import 'dart:io';

import '../controller/photo_controller.dart';

class ShareMushroom extends StatefulWidget {
  const ShareMushroom({Key? key}) : super(key: key);

  @override
  _ShareMushroomState createState() => _ShareMushroomState();
}

class _ShareMushroomState extends State<ShareMushroom> {
  final PhotoController photoController = Get.put(PhotoController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await photoController.pickImageGallery();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            return photoController.image.value != null
                ? Stack(alignment: Alignment.topRight, children: [
                    Image.file(
                      photoController.image.value!,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 12, right: 12),
                        child: CustomButton(
                          buttonText: 'İleri',
                          onPressed: () {
                            if (photoController.image.value != null) {
                              Get.to(() => AddDescriptionPage(
                                    imageFile: photoController.image.value!,
                                  ));
                            }
                          },
                        )),
                  ])
                : Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.camera_alt,
                            size: 50, color: Colors.grey[600]),
                        onPressed: () async {
                          await photoController.pickImageGallery();
                        },
                      ),
                    ),
                  );
          }),
          Expanded(
            child: Center(
              child: Obx(() {
                if (photoController.image.value == null) {
                  return const Text('No Image Selected');
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class AddDescriptionPage extends StatelessWidget {
  final File imageFile;

  AddDescriptionPage({required this.imageFile, Key? key}) : super(key: key);

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.file(
              imageFile,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Konum',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(buttonText: 'Paylaş', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
