import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/user_tab_controller.dart';
import 'package:tez_front/widgets/custom_button.dart';

class UserTab extends StatelessWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const name = 'Rumeysa Alkaya';

    UserTabController controller = Get.put(UserTabController());

    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
        ),
        const Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Obx(() {
              switch (controller.tabIndex.value) {
                case 0:
                  return CustomButton(
                      buttonText: 'Kaydedilenler',
                      onPressed: () {
                        Get.to(const _ImageListWidget());
                      });
                case 1:
                  return CustomButton(
                      buttonText: 'Paylaşılanlar',
                      onPressed: () {
                        Get.to(const _ImageListWidget());
                      });
                default:
                  return const SizedBox();
              }
            }),
          ],
        )
      ],
    );
  }
}

class _ImageListWidget extends StatelessWidget {
  const _ImageListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
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
      ),
    );
  }
}
