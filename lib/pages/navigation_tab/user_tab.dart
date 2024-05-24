import 'package:flutter/material.dart';
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

class _ImageListWidget extends StatelessWidget {
  const _ImageListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
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
                          Expanded(
                            child: Hero(
                              tag: 'image_$index',
                              child: Image.network(
                                'https://via.placeholder.com/150',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: ListTile(
              title: Text('Image ${index + 1}'),
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
          ),
        );
      },
    );
  }
}
