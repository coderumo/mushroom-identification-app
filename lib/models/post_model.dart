import 'package:tez_front/models/liked_model.dart';

class PostModel {
  final String id;
  final String? description;
  final String image;
  final String? place;
  final String? latitude;
  final String? longtitude;
  final String userId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final PostUserModel? user;
  final List<LikedModel> likes;
  final String? type;

  PostModel({
    required this.id,
    required this.description,
    required this.image,
    required this.place,
    required this.latitude,
    required this.longtitude,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
    required this.likes,
    this.type,
  });

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Null JSON provided to PostModel");
    }

    return PostModel(
      id: json['id'] ?? '',
      description: json['description'],
      image: json['image'] ?? '',
      place: json['place'],
      latitude: json['latitude']?.toString(),
      longtitude: json['longtitude']?.toString(),
      userId: json['userId'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      user: json['user'] != null ? PostUserModel.fromJson(json['user']) : null,
      likes: (json['likes'] as List<dynamic>?)?.map((item) => LikedModel.fromJson(item as Map<String, dynamic>)).toList() ?? [],
      type: json['specie'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'place': place,
        'latitude': latitude.toString(),
        'longtitude': longtitude.toString(),
        'userId': userId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
        'user': user?.toJson(),
        'likes': likes.map((like) => like.toJson()).toList(),
        'specie': type,
      };

  String time(DateTime? time) {
    if (time == null) return '';
    return "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}";
  }
}

class PostRequestModel {
  final String description;
  final String specie;
  final String place;
  final String latitude;
  final String longitude;

  PostRequestModel({
    required this.description,
    required this.specie,
    required this.place,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'specie': specie,
        'place': place,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  String toString() {
    return 'PostRequestModel(description: $description, specie: $specie, place: $place, latitude: $latitude, longtitude: $longitude)';
  }
}

class PostUserModel {
  final String id;
  final String name;
  final String? userName;
  final String email;
  final String? profileImage;

  PostUserModel({
    required this.id,
    required this.name,
    this.userName,
    required this.email,
    required this.profileImage,
  });

  factory PostUserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Null JSON provided to PostUserModel");
    }
    return PostUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      userName: json['userName'],
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userName': userName,
        'email': email,
        'profileImage': profileImage,
      };

  @override
  String toString() {
    return 'PostUserModel{id: $id, name: $name, userName: $userName, email: $email, profileImage: $profileImage}';
  }
}
