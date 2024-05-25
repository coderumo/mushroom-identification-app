import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/project_paddings.dart';
import 'package:tez_front/constants/sized_box_constant.dart';
import 'package:tez_front/controller/user_tab_controller.dart';

class UserTab extends StatelessWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String name = 'Rumeysa Alkaya';
    const String url = 'https://via.placeholder.com/150';
    const String tabText1 = 'Kaydedilenler';
    const String tabText2 = 'Paylaşılanlar';
    const double raidus = 60;

    UserTabController controller = Get.put(UserTabController());

    return Column(
      children: [
        const CircleAvatar(
          radius: raidus,
          backgroundImage: NetworkImage(url),
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
          tabs: const [
            Tab(text: tabText1),
            Tab(text: tabText2),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: const [
              _ImageListWidget(),
              _ImageListWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImageListWidget extends StatefulWidget {
  const _ImageListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<_ImageListWidget> {
  late final List<ImageModel> _items;

  @override
  void initState() {
    super.initState();
    _items = ImageListItems().items;
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
              _onTap(context, index);
            },
            child: _MushroomCard(model: _items[index]),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: SizedBoxConstant.width,
            height: SizedBoxConstant.heigth,
            child: Expanded(child: Image.asset(_items[index].imagePath)),
          ),
        );
      },
    );
  }
}

class _MushroomCard extends StatelessWidget {
  const _MushroomCard({
    required ImageModel model,
  }) : _model = model;

  final ImageModel _model;

  @override
  Widget build(BuildContext context) {
    const String konum = 'konum ???';

    return Card(
      child: Padding(
        padding: ProjectPaddings.paddingAll,
        child: SizedBox(
          height: SizedBoxConstant.heigth,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  _model.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(_model.date), const Text(konum)],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageModel {
  final String imagePath;
  final String date;

  ImageModel({required this.imagePath, required this.date});
}

class ImageListItems {
  late final List<ImageModel> items;

  ImageListItems() {
    items = [
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
    ];
  }
}
