import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  final String id;
  final String description;
  final String image;
  final String latitude;
  final dynamic longitude;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final User user;

  PostModel({
    required this.id,
    required this.description,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    return PostModel(
      id: json?['id'] ?? '',
      description: json?['description'] ?? '',
      image: json?['image'] ?? '',
      latitude: json?['latitude'] ?? '',
      longitude: json?['longitude'],
      userId: json?['userId'] ?? '',
      createdAt: json?['createdAt'] ?? '',
      updatedAt: json?['updatedAt'] ?? '',
      deletedAt: json?['deletedAt'],
      user: User.fromJson(json?['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'latitude': latitude,
        'longitude': longitude,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'user': user.toJson(),
      };
}

class User {
  final String id;
  final String name;
  final String? userName;
  final String email;
  final String password;
  final String profileImage;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json?['id'] ?? '',
      name: json?['name'] ?? '',
      userName: json?['userName'],
      email: json?['email'] ?? '',
      password: json?['password'] ?? '',
      profileImage: json?['profileImage'] ?? '',
      createdAt: json?['createdAt'] ?? '',
      updatedAt: json?['updatedAt'] ?? '',
      deletedAt: json?['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userName': userName,
        'email': email,
        'password': password,
        'profileImage': profileImage,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}
