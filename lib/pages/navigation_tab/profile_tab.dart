import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/constants/padding_constant.dart';
import 'package:tez_front/constants/sized_box_constant.dart';
import 'package:tez_front/controller/user_tab_controller.dart';
import 'package:tez_front/models/post_api_response.dart';
import 'package:tez_front/models/post_model.dart';

class UserTab extends StatelessWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserTabController controller = Get.put(UserTabController());

    return Obx(() {
      // Kullanıcı bilgilerini dinamik olarak yükle
      final user = controller.user.value;
      final String name = user?.name ?? 'Kullanıcı Adı';
      final String url =
          user?.profileImage ?? 'https://via.placeholder.com/150';
      const double radius = 60;

      return Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () async {
                  final XFile? image = await controller.pickImage();
                  if (image == null) {
                    return;
                  }
                  final res = await controller.authService
                      .setProfileImage(File(image.path));
                  if (res.success) {
                    Get.snackbar('Başarılı', 'Profil resmi güncellendi');
                  } else {
                    Get.snackbar(res.message, res.message);
                  }
                  await controller.fetchUserProfile();
                },
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: NetworkImage(url),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: () async {
                    final XFile? image = await controller.pickImage();
                    if (image == null) {
                      return;
                    }
                    final res = await controller.authService
                        .setProfileImage(File(image.path));
                    if (res.success) {
                      Get.snackbar('Başarılı', 'Profil resmi güncellendi');
                    } else {
                      Get.snackbar(res.message, res.message);
                    }
                    await controller.fetchUserProfile();
                  },
                  child: CircleAvatar(
                    radius: radius * 0.3,
                    backgroundColor: ColorConstants.darkGreen.withOpacity(0.8),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: radius * 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: ProjectPaddings.paddingAll,
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TabBar(
            controller: controller.tabController,
            tabs: MyTabViews.values
                .map((e) => Tab(text: e.name))
                .toList()
                .reversed
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                PostWidget(),
                SavedPostWidget(),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class SavedPostWidget extends StatefulWidget {
  const SavedPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedPostWidget> createState() => _SavedPostWidgetState();
}

class _SavedPostWidgetState extends State<SavedPostWidget> {
  List<PostModel> _items = [];

  void getDraft() async {
    final res = await UserTabController().authService.getDraft();
    if (res.success) {
      final data = res.data['data'] as List;

      final items = data.map((e) => PostModel.fromJson(e)).toList();
      setState(() {
        _items = items;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: ProjectPaddings.paddingAll,
          child: InkWell(
            onTap: () {
              onTap(context, index, _items);
            },
            child: _MushroomCard(model: _items[index]),
          ),
        );
      },
    );
  }
}

enum MyTabViews { Kaydedilenler, Paylasilanlar }

extension MyTabViewExtension on MyTabViews {}

class _MushroomCard extends StatelessWidget {
  const _MushroomCard({
    required PostModel model,
    Key? key,
  })  : _model = model,
        super(key: key);

  final PostModel _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ProjectPaddings.paddingAll,
        child: SizedBox(
          height: SizedBoxConstant.heigth,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  _model.image,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_model.time(_model.createdAt)),
                  Text(_model.place ?? ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

{id: 459c9b8e-548f-41b2-8e15-d1f748b5d62d, description: karahan deniz görmüş , image: https://storage.googleapis.com/mush-app/mush-images/b8d5af54-21e4-4f4c-8bb0-767d452ea78f.jpg, place: , Atakum, latitude: 41.37, longtitude: null, userId: d214d84d-2635-41c9-8859-9bc24cad3e69, createdAt: 2024-07-01T12:21:32.879Z, updatedAt: 2024-07-01T12:21:32.879Z, deletedAt: null}
  
  */

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  List<PostModel> _items = [];
  bool isLoading = false;

  void getposts() async {
    setState(() {
      isLoading = true;
    });
    final res = await UserTabController().authService.getPost();
    if (res.success) {
      final data = res.data['data'] as List;

      final items = data.map((e) => PostModel.fromJson(e)).toList();
      setState(() {
        _items = items;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getposts();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: ProjectPaddings.paddingAll,
          child: InkWell(
            onTap: () {
              onTap(context, index, _items);
            },
            child: _MushroomCard(model: _items[index]),
          ),
        );
      },
    );
  }
}

void onTap(BuildContext context, int index, List<PostModel> items) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: SizedBoxConstant.width,
          height: SizedBoxConstant.heigth,
          child: Image.asset(items[index].image, fit: BoxFit.cover),
        ),
      );
    },
  );
}
