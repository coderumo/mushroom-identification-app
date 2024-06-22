class Post {
  final String id;
  final String description;
  final String image;
  final String userId;

  Post({
    required this.id,
    required this.description,
    required this.image,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      userId: json['userId'],
    );
  }
}
