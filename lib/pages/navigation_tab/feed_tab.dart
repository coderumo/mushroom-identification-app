import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NoData();
  }
}

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;
    int index = 0;
    return ListView(
      children: [
        feedCard(deviceHeight: deviceHeight, deviceWidth: deviceWidth)
      ],
    );
  }
}

class feedCard extends StatelessWidget {
  const feedCard({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
  });

  final double deviceHeight;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 139, 194, 140),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: deviceHeight / 5,
        width: deviceWidth / 3,
        child: const Row(),
      ),
    );
  }
}
