import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tez_front/constants/color_constant.dart';
import 'package:tez_front/constants/padding_constant.dart';
import 'package:tez_front/constants/sized_box_constant.dart';
import 'package:tez_front/controller/user_tab_controller.dart';
import 'package:tez_front/models/classify_model.dart';
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

      return Material(
        child: Column(
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
                      backgroundColor:
                          ColorConstants.darkGreen.withOpacity(0.8),
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
        ),
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

  @override
  void initState() {
    super.initState();
    getDraft();
  }

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

  Future<void> deletePost(int index) async {
    try {
      await UserTabController().authService.deletePost(_items[index].id);
      setState(() {
        _items.removeAt(index);
      });
      Get.snackbar('Başarılı', 'Gönderi başarıyla silindi.');
    } catch (e) {
      Get.snackbar('Hata', 'Gönderi silinirken bir hata oluştu: $e');
    }
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
            child: _MushroomCard(
              model: _items[index],
              onDelete: () => deletePost(index),
            ),
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
    required this.onDelete,
    Key? key,
  })  : _model = model,
        super(key: key);

  final PostModel _model;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ProjectPaddings.paddingAll,
        child: SizedBox(
          height: SizedBoxConstant.heigth,
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    _model.trueLabels,
                    style: const TextStyle(color: Colors.black),
                  ),
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
                  Row(
                    children: [
                      Text(_model.canEat ? "Yenilebilir" : "Yenilemez"),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    getMyposts();
  }

  void getMyposts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await UserTabController().authService.getMyPost();
      if (res.success) {
        final data = res.data as List;
        final items = data.map((e) => PostModel.fromJson(e)).toList();
        setState(() {
          _items = items;
        });
      }
    } catch (e) {
      // Hata durumunda ne yapılacaksa burada belirleyin
      print('Hata: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deletePost(int index) async {
    try {
      await UserTabController().authService.deletePost(_items[index].id);
      setState(() {
        _items.removeAt(index);
      });
      Get.snackbar('Başarılı', 'Gönderi başarıyla silindi.');
    } catch (e) {
      Get.snackbar('Hata', 'Gönderi silinirken bir hata oluştu: $e');
    }
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
            child: _MushroomCard(
              model: _items[index],
              onDelete: () => deletePost(index),
            ),
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
          child: Image.network(items[index].image, fit: BoxFit.contain),
        ),
      );
    },
  );
}
