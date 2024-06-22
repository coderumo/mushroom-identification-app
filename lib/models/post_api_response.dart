import 'package:tez_front/models/post_model.dart';

class ApiResponse {
  final List<Post> posts;

  ApiResponse({required this.posts});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var data = json['data']['data'];

    if (data != null && data is List) {
      List<Post> posts =
          data.map((postJson) => Post.fromJson(postJson)).toList();
      return ApiResponse(posts: posts);
    } else {
      throw Exception('Invalid JSON format or null data');
    }
  }
}
