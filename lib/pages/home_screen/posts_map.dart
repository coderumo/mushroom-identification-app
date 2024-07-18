import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tez_front/models/post_model.dart';
import 'package:tez_front/pages/home_screen/feed_page.dart';
import 'package:tez_front/services/auth_service.dart';
import 'package:latlong2/latlong.dart';

class PostMap extends StatefulWidget {
  const PostMap({
    super.key,
  });

  @override
  State<PostMap> createState() => _PostMapState();
}

class _PostMapState extends State<PostMap> {
  bool isLoading = false;

  List<PostModel> posts = [];

  void getPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final AuthService _authService = AuthService();
      final res = await _authService.getPost(getUsers: true);
      if (res.success) {
        print('Response data: ${res.data}');
        final data = res.data['data'] as List;
        final items = data.map((e) => PostModel.fromJson(e)).toList();
        setState(() {
          posts = items;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mushroom App'),
      ),
      body: FlutterMap(
        options: MapOptions(
          maxZoom: 18,
          minZoom: 5,
          initialCenter: posts.isNotEmpty ? LatLng(double.parse(posts.first.latitude ?? '41.40'), double.parse(posts.first.longtitude ?? '36.23')) : const LatLng(41.40, 36.23),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
            userAgentPackageName: 'pinsar.com.tr',
          ),
          MarkerLayer(
            markers: [
              for (var post in posts)
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(double.parse(post.latitude ?? '41.40'), double.parse(post.longtitude ?? '36.23')),
                  child: InkWell(
                    onTap: () {
                      final size = MediaQuery.of(context).size;
                      showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text(post.place ?? 'Mushroom App'),
                              ),
                              body: Center(
                                child: SizedBox.fromSize(
                                  size: size * 0.8,
                                  child: FeedCard(post: post),
                                ),
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 80.0,
                          color: Colors.red,
                        ),
                        Positioned(
                          top: 10,
                          right: 0,
                          left: 0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(post.image ?? 'https://via.placeholder.com/150'),
                            radius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
