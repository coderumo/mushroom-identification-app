import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/models/mushroom_model.dart';

import '../../controller/mushroom_controller.dart';

class FeedPage extends StatelessWidget {
  final MushroomController _controller = Get.put(MushroomController());

  FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Mantar Türleri",
              style: TextStyle(
                color: ColorConstants.darkGreen,
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ]),
        ),
        body: Obx(
          () => _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _controller.mushrooms.isEmpty
                  ? const Center(
                      child: Text('No mushrooms found.'),
                    )
                  : ListView.builder(
                      itemCount: _controller.mushrooms.length,
                      itemBuilder: (context, index) {
                        MushroomModel mushroom = _controller.mushrooms[index];
                        return ListTile(
                          title: Text(mushroom.title),
                          subtitle: Text("${mushroom.id}"),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(mushroom.url),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
