import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/pages/home_screen/map_page.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:tez_front/widgets/custom_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the spinkit package
import '../constants/color_constant.dart'; // Make sure to import your color constants
import 'home_page.dart'; // Import the HomePage

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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantar Paylaş'),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitFadingCircle(
                color: ColorConstants.darkGreen,
                size: 50.0,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _image == null
                      ? const Text('Fotoğraf seçilmedi.')
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
                          konum = "${location['city'] ?? ''}${location['city'] != null ? ',' : ''}${location['district'] ?? ''}";
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


                      print(requestModel);

                      try {
                        setState(() {
                          isLoading = true;
                        });
                        AuthService authService = AuthService();
                        final res = await authService.createPost(requestModel, _image!);
                        if (res.success) {
                          Get.snackbar('Başarılı', 'Gönderi başarıyla paylaşıldı');
                          Get.offAll(() => const HomePage()); // Navigate to HomePage
                        } else {
                          Get.snackbar('Hata', res.message);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        Get.snackbar('Hata', e.toString());
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
