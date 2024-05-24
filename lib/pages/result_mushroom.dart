import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/widgets/custom_button.dart';

import '../controller/photo_controller.dart';

class ResultMushroom extends StatelessWidget {
  const ResultMushroom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;

    const title = 'MANTAR ADI';
    const subTitle = 'Zehirli/Zehirsiz';
    final bodyText = 'deneme ' * 100;
    const buttonText = 'Kaydet ve Paylaş';
    const buttonText2 = 'Kaydet';
    const buttonText3 = 'İptal';

    PhotoController photoController = Get.find();

    return Scaffold(
      body: Obx(
        () {
          if (photoController.image.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          fit: BoxFit.fill,
                          photoController.image.value!,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ColorConstants.darkGreen, width: 2)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            buttonText: buttonText,
                            onPressed: photoController.saveAndShareImage),
                        CustomButton(
                            buttonText: buttonText2,
                            onPressed: photoController.saveAndShareImage),
                        CustomButton(
                            buttonText: buttonText3,
                            onPressed: photoController.cancel),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      const _TitleWidget(title: title),
                      const SizedBox(
                        height: 10,
                      ),
                      const _SubTitleWidget(subTitle: subTitle),
                      _TextWidget(bodyText: bodyText),
                    ],
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

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    required this.bodyText,
  });

  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Text(
      bodyText,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.w400),
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
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w500),
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
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
