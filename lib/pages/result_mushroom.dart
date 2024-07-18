import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tez_front/controller/map_controller.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:tez_front/widgets/custom_button.dart';
import '../constants/color_constant.dart';
import '../controller/photo_controller.dart';
import '../models/post_model.dart';
import '../controller/db_manager.dart'; // Ensure you have this import

class ResultMushroom extends StatefulWidget {
  final String title;
  final String subTitle;
  final String bodyText;
  final double predictedProb;
  final File image;

  const ResultMushroom({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.bodyText,
    required this.image,
    required this.predictedProb,
  }) : super(key: key);

  @override
  State<ResultMushroom> createState() => _ResultMushroomState();
}

class _ResultMushroomState extends State<ResultMushroom> {
  final AuthService authService = AuthService();
  final TextEditingController _textController = TextEditingController();

  PhotoController photoController = Get.find();
  MapController mapController = Get.put(MapController());
  String address = '';
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const buttonText = 'Paylaş';
    const buttonText2 = 'Kaydet';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuç'),
      ),
      body: Obx(
        () {
          if (photoController.image.value == null) {
            return const Center(
              child: SpinKitFadingCircle(
                color: ColorConstants.darkGreen,
                size: 50.0,
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  height: deviceHeight * 0.4,
                  width: deviceWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Image.file(
                    photoController.image.value!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.darkGreen,
                            width: 2,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!Database.instance.isGuest())
                            CustomButton(
                              buttonText: buttonText,
                              onPressed: () async {
                                await Get.bottomSheet(
                                  BottomSheet(
                                    onClosing: () {
                                      Get.snackbar('İptal', 'İşlem iptal edildi');
                                    },
                                    builder: (context) => SizedBox(
                                      height: size.height * 0.2,
                                      width: size.width,
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: TextField(
                                              controller: _textController,
                                              decoration: const InputDecoration(
                                                hintText: 'Açıklama (isteğe bağlı)',
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await mapController.getCurrentLocation();
                                              if (mapController.selectedLocation.value != null) {
                                                Get.back();
                                                final postRequestModel = PostRequestModel(
                                                  description: _textController.text,
                                                  specie: widget.title,
                                                  place: address,
                                                  latitude: mapController.selectedLocation.value!.latitude.toString(),
                                                  longitude: mapController.selectedLocation.value!.longitude.toString(),
                                                );

                                                await authService.createPost(postRequestModel, widget.image);
                                                Get.snackbar('Başarılı', 'Gönderi başarıyla paylaşıldı');
                                              } else {
                                                Get.snackbar('Hata', 'Konum alınamadı.');
                                              }
                                            },
                                            child: const Text('Paylaş'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                Get.back();
                              },
                            ),
                          if (!Database.instance.isGuest())
                            CustomButton(
                              buttonText: buttonText2,
                              onPressed: () async {
                                await mapController.getCurrentLocation();
                                if (mapController.selectedLocation.value != null) {
                                  setState(() {
                                    address = mapController.address.value;
                                    selectedLocation = mapController.selectedLocation.value;
                                  });
                                  Get.snackbar('Kaydedildi', 'Gönderi Başarıyla kaydedildi');
                                  await savePost(mapController.selectedLocation.value!);
                                } else {
                                  Get.snackbar('Hata', 'Konum alınamadı.');
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        _TitleWidget(title: widget.title),
                        if (widget.predictedProb < 50) const Text("Doğruluk oranı düşük bilgileri teyit etmek için uzman birine danışın."),
                        const SizedBox(
                          height: 10,
                        ),
                        _SubTitleWidget(subTitle: widget.subTitle),
                        _TextWidget(bodyText: widget.bodyText),
                        const SizedBox(
                          height: 10,
                        ),
                        if (address.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Adres: $address'),
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

  Future<void> savePost(LatLng loc) async {
    final postRequestModel = PostRequestModel(
      description: _textController.text,
      specie: widget.title,
      place: address,
      latitude: loc.latitude.toString(),
      longitude: loc.longitude.toString(),
    );
    try {
      await authService.createDraft(postRequestModel, widget.image);
      Get.snackbar('Başarılı', 'Gönderi başarıyla kaydedildi.');
    } catch (e) {
      Get.snackbar('Hata', 'Gönderi kaydedilirken bir hata oluştu: $e');
    }
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    required this.bodyText,
  });

  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Text(
      bodyText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
    );
  }
}

class _SubTitleWidget extends StatelessWidget {
  const _SubTitleWidget({
    required this.subTitle,
  });

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: subTitle == 'Yenilebilir' ? ColorConstants.darkGreen : Colors.red),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
