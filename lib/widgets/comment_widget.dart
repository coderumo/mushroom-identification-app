import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/comment_controller.dart';

class CommentSheet extends StatefulWidget {
  final String postId;
  final List<String> comments;

  const CommentSheet({Key? key, required this.postId, required this.comments}) : super(key: key);

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    commentController.getPostComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    const hintText = 'Add a comment...';

    TextEditingController commentControllerText = TextEditingController();

    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () {
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: commentController.comments.length,
                            itemBuilder: (context, index) {
                              final image = commentController.comments[index].userImage;
                              return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: image != null ? NetworkImage(commentController.comments[index].userImage!) : null,
                                    child: image == null ? const Icon(Icons.person, color: Colors.white) : null,
                                  ),
                                  title: Text(commentController.comments[index].username, style: Theme.of(context).textTheme.titleMedium),
                                  subtitle: Text(commentController.comments[index].description),
                                  trailing: Text(commentController.comments[index].date.forCommentDateString()));
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentControllerText,
                              decoration: InputDecoration(
                                hintText: hintText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              commentController.addComment(commentControllerText.text, widget.postId);
                              commentControllerText.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
