import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/share_add_description.dart';
import 'package:tez_front/widgets/custom_app_bar.dart';
import 'package:tez_front/widgets/custom_button.dart';
import 'dart:io';

import '../controller/photo_controller.dart';

class ShareMushroom extends StatelessWidget {
  ShareMushroom({Key? key}) : super(key: key);

  final PhotoController controller = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni gönderi'),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(AddDescriptionPage(imageFile: controller.image.value!));
            },
            child: Text(
              'İleri',
              style: TextStyle(
                  color: Theme.of(context).copyWith().primaryColorDark),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).height,
            child: Obx(
              () => controller.image.value != null
                  ? Image.file(
                      controller.image.value!,
                    )
                  : const Center(
                      child: Text(
                        'Fotoğraf seçin',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: controller.pickImageGallery,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: controller.openCamera,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
