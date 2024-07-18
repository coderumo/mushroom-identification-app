class LikedModel {
  final bool isLiked;
  final String postId;
  final String userId;
  final dynamic deletedAt;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  LikedModel({
    required this.isLiked,
    required this.postId,
    required this.userId,
    this.deletedAt,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LikedModel.fromJson(Map<String, dynamic> json) {
    return LikedModel(
      isLiked: json['isLiked'] ?? false,
      postId: json['postId'],
      userId: json['userId'],
      deletedAt: json['deletedAt'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLiked': isLiked,
      'postId': postId,
      'userId': userId,
      'deletedAt': deletedAt,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
