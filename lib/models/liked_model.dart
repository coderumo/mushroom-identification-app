class LikedModel {
  final bool isLiked;
  final String postId;
  final String userId;
  final String id;

  LikedModel({
    required this.isLiked,
    required this.postId,
    required this.userId,
    required this.id,
  });

  factory LikedModel.fromJson(Map<String, dynamic> json) {
    return LikedModel(
      isLiked: json['isLiked'] ?? false,
      postId: json['postId'],
      userId: json['userId'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLiked': isLiked,
      'postId': postId,
      'userId': userId,
      'id': id,
    };
  }
}
