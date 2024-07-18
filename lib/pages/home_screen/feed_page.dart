import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/comment_controller.dart';
import 'package:tez_front/controller/db_manager.dart';
import 'package:tez_front/controller/user_tab_controller.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/models/user_model.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:tez_front/widgets/comment_widget.dart';

import '../../constants/color_constant.dart';
import '../../models/liked_model.dart';

class FeedList extends StatefulWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  FeedListState createState() => FeedListState();
}

class FeedListState extends State<FeedList> {
  List<PostModel> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await UserTabController().authService.getPost();
      if (res.success) {
        print('Response data: ${res.data}');
        final data = res.data['data'] as List;
        final items = data.map((e) => PostModel.fromJson(e)).toList();
        setState(() {
          posts = items;
          isLoading = false;
        });
      } else {
        print('Error: ${res.message}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantar Keşfet'),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitFadingCircle(
                color: ColorConstants.darkGreen,
                size: 50.0,
              ),
            )
          : posts.isEmpty
              ? Center(
                  child: Text(
                  'Gönderi yok',
                  style: Theme.of(context).textTheme.bodyLarge,
                ))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return FeedCard(post: posts[index]);
                  },
                ),
    );
  }
}

class FeedCard extends StatefulWidget {
  final PostModel post;
  final Size? size;

  const FeedCard({Key? key, required this.post, this.size}) : super(key: key);

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool _isLiked = false;
  int likeCount = 0;
  @override
  void initState() {
    super.initState();
    final user = Database().getUser();
    _isLiked = widget.post.likes.any((like) => like.userId == user?.id);
    likeCount = widget.post.likes.length;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: widget.post.user?.profileImage != null ? NetworkImage(widget.post.user!.profileImage!) : null,
                radius: 20,
                child: widget.post.user?.profileImage == null ? const Icon(Icons.person) : null,
              ),
              title: Text(widget.post.user?.userName ?? ''),
              subtitle: widget.post.type != null ? Text(widget.post.type!) : null,
              trailing: Text(widget.post.createdAt.forCommentDateString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: widget.size?.width ?? size.width,
                height: widget.size?.height ?? size.height * 0.4,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(imageUrl: widget.post.image)));
                      },
                      child: Image.network(
                        widget.post.image,
                        width: widget.size?.width ?? size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Material(
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        color: Colors.black.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.8,
                                      child: Text(
                                        widget.post.description ?? '',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Material(
                                        elevation: 3,
                                        shape: ShapeBorder.lerp(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          0.5,
                                        ),
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  _isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up,
                                                  color: _isLiked ? Colors.blue : Colors.black,
                                                ),
                                                const SizedBox(width: 8),
                                                Text('$likeCount Beğeni'),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            _toggleLike();
                                            setState(() {
                                              _isLiked = !_isLiked;
                                              likeCount += _isLiked ? 1 : -1;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Material(
                                      elevation: 3,
                                      shape: ShapeBorder.lerp(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        0.5,
                                      ),
                                      child: InkWell(
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                                          child: Row(
                                            children: [
                                              Icon(Icons.comment),
                                              SizedBox(width: 8),
                                              Text('Yorum Yap'),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          _showCommentsSheet(context);
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context) {
    Get.bottomSheet(
      CommentSheet(
        postId: widget.post.id,
        comments: const [], // Yorumları buraya ekleyin
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _toggleLike() async {
    try {
      LikedModel liked = await AuthService().likePost(widget.post.id, !_isLiked);

      print('Liked model: $liked'); // Kontrol için konsola yazdırma

      setState(() {
        _isLiked = liked.isLiked;
      });
    } catch (e) {
      print('Error toggling like: $e');
    }
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;
  const ImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(child: Image.network(imageUrl)),
      ),
    );
  }
}
