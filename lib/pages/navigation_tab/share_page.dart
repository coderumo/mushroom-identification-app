import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../controller/photo_controller.dart';

class ShareMushroom extends StatelessWidget {
  final PhotoController photoController = Get.put(PhotoController());

  ShareMushroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 4; // Galeri gridindeki sütun sayısı
    double itemHeight = screenHeight * 0.1; // Galeri öğesinin yüksekliği
    int rowCount = ((screenHeight * 0.5) / itemHeight)
        .floor(); // Yarı ekranı kaplayacak satır sayısı
    int itemCount = crossAxisCount * rowCount; // Örnek resim sayısı

    return Column(
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
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (photoController.image.value != null) {
                          Get.to(() => AddDescriptionPage(
                                imageFile: photoController.image.value!,
                              ));
                        }
                      },
                      child: const Text('İleri'),
                    ),
                  ),
                ])
              : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('No Image Selected'),
                  ),
                );
        }),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await photoController.pickImageGallery();
                },
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
      appBar: AppBar(
        title: const Text('Add Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.file(
              imageFile,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save and share logic
              },
              child: const Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
