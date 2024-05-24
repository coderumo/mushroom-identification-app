import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/pages/first_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Expanded(
            child: Image.asset(
          'assets/images/logo-g.png',
          height: 40,
        )),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const _CustomNotificationWidget();
                    });
              },
              icon: const Icon(
                Icons.notifications,
              )),
          IconButton(
              onPressed: () {
                Get.off(const FirstPage());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomNotificationWidget extends StatelessWidget {
  const _CustomNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 300,
          height: 300,
          child: ListView(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '@sadfndfk Fotoğrafını beğendi',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
