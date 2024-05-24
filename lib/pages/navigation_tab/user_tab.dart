import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/user_tab_controller.dart';

class UserTab extends StatelessWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const name = 'Rumeysa Alkaya';
    const url = 'https://via.placeholder.com/150';
    const tabText1 = 'Kaydedilenler';
    const tabText2 = 'Paylaşılanlar';

    UserTabController controller = Get.put(UserTabController());

    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
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
    _items = [
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
      ImageModel(imagePath: 'assets/images/mantar.png', date: '02.12.2024'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          Expanded(child: Image.asset(_items[index].imagePath)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          _items[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tarih: ${_items[index].date}',
                          ),
                          const Text('Konum  ??')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageModel {
  final String imagePath;
  final String date;

  ImageModel({required this.imagePath, required this.date});
}
