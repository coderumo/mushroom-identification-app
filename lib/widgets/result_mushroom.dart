import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controller/photo_controller.dart';

class ResultMushroom extends StatelessWidget {
  const ResultMushroom({
    Key? key,
    required this.photoController,
  }) : super(key: key);

  final PhotoController photoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (photoController.image.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Image.file(
                        photoController.image.value!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: photoController.saveAndShareImage,
                          child: const Text(
                            'Kaydet ve Paylaş',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: photoController.saveImage,
                          child: const Text(
                            'Kaydet',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView(
                      children: const [
                        Text(
                          textAlign: TextAlign.center,
                          'MANTAR ADI',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ZEHİRLİ/ZEHİRSİZ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
