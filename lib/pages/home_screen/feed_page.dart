import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/constants/padding_constant.dart';
import 'package:tez_front/controller/auth_controller.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/widgets/custom_app_bar.dart';

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

class FeedCard extends StatefulWidget {
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
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceWidth = mediaQueryData.size.width;
    final double imageHeight = (deviceWidth * 16) / 16;
    const loadingGiphy = 'assets/gif/giphy.gif';
    const commentText = 'Yorumları Göster..';

    final _Paddings padding = _Paddings();
    final _CustomBorderRadius radius = _CustomBorderRadius();

    return Padding(
      padding: padding.paddingAll,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: radius.circularAll,
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              title: Text(widget.username),
            ),
            Container(
              width: double.infinity,
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: radius.radiusOnlyTB,
              ),
              child: ClipRRect(
                borderRadius: radius.radiusOnlyTB,
                child: FadeInImage.assetNetwork(
                  placeholder: loadingGiphy,
                  image: widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: imageHeight,
                ),
              ),
            ),
            Padding(
              padding: padding.paddingAll,
              child: Text(widget.description),
            ),
            Padding(
              padding: padding.paddingAll,
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CommentSheet(
                          postId: widget.username, comments: widget.comments),
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: Text(
                  commentText,
                  style: TextStyle(
                      color: Theme.of(context).copyWith().primaryColorDark),
                ),
              ),
            ),
            Padding(
              padding: padding.paddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {
                      if (Database().isGuest()) {
                        authController.snackBar();
                      } else {
                        //backende istek
                        printError();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      if (!Database().isGuest()) {
                        Get.bottomSheet(
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CommentSheet(
                                postId: widget.username,
                                comments: widget.comments),
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      } else {
                        authController.snackBar();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      if (Database().isGuest()) {
                        authController.snackBar();
                      } else {
                        //backende istek
                        printError();
                      }
                    },
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

class _CustomBorderRadius {
  final circularAll = BorderRadius.circular(15.0);
  final radiusOnlyTB = const BorderRadius.only(
    bottomLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  );
}

class _Paddings {
  final topPadding = const EdgeInsets.only(top: 10);
  final bottomPadding = const EdgeInsets.only(bottom: 10);
  final paddingAll = const EdgeInsets.all(8);
}
