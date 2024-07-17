import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tez_front/controller/user_tab_controller.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/widgets/comment_widget.dart';

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
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? const Center(child: Text('No posts available'))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return FeedCard(post: posts[index]);
                  },
                ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final PostModel post;

  const FeedCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListTile(
          //   leading: CircleAvatar(
          //     backgroundImage: NetworkImage(post.user.profileImage),
          //   ),
          //   title: Text(post.user.name),
          // ),
          Image.network(
            post.image,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description ?? ''),
          ),
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
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    // Beğeni işlemleri burada yapılabilir
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
    );
  }

  void _showCommentsSheet(BuildContext context) {
    Get.bottomSheet(
      CommentSheet(
        postId: post.id,
        comments: const [], // Yorumları buraya ekleyin
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
