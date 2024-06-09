import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/widgets/app_bar_custom.dart';

import '../../widgets/comment_widget.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FeedList();
  }
}

class FeedList extends StatelessWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return FeedCard(
            username: 'User $index',
            imageUrl: 'https://via.placeholder.com/400x711',
            description: 'Fotoğraf paylaşan kişinin açıklaması',
            comments: List.generate(3, (i) => 'Comment $i'),
          );
        },
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String description;
  final List<String> comments;

  const FeedCard({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.description,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceWidth = mediaQueryData.size.width;
    final double imageHeight = (deviceWidth * 16) / 16;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              title: Text(username),
            ),
            Container(
              width: double.infinity,
              height: imageHeight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/gif/giphy.gif',
                  image: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: imageHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CommentSheet(postId: username, comments: comments),
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: const Text(
                  'Yorumları Göster..',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      Get.bottomSheet(
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: CommentSheet(
                              postId: username, comments: comments),
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
