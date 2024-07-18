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

  @override
  void initState() {
    super.initState();
    final user = Database().getUser();
    _isLiked = widget.post.likes.any((like) => like.userId == user?.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
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
            subtitle: Text(widget.post.createdAt.forCommentDateString()),
          ),
          SizedBox(
            height: widget.size?.height ?? size.height * 0.5,
            child: Image.network(
              widget.post.image,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.description ?? ''),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _showCommentsSheet(context);
                  },
                  child: Text(
                    'Yorumları Göster..',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up,
                        color: _isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        _toggleLike();
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        _showCommentsSheet(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Paylaşma işlemleri burada yapılabilir
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
