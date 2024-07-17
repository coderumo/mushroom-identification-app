/* {id: 459c9b8e-548f-41b2-8e15-d1f748b5d62d, description: karahan deniz görmüş , image: https://storage.googleapis.com/mush-app/mush-images/b8d5af54-21e4-4f4c-8bb0-767d452ea78f.jpg, place: , Atakum, latitude: 41.37, longtitude: null, userId: d214d84d-2635-41c9-8859-9bc24cad3e69, createdAt: 2024-07-01T12:21:32.879Z, updatedAt: 2024-07-01T12:21:32.879Z, deletedAt: null}*/
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
  });

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    return PostModel(
      id: json?['id'] ?? '',
      description: json?['description'] ?? '',
      image: json?['image'] ?? '',
      place: json?['place'],
      latitude: json?['latitude'],
      longtitude: json?['longtitude'],
      userId: json?['userId'] ?? '',
      createdAt: DateTime.parse(json?['createdAt'] ?? ''),
      updatedAt: json?['updatedAt'] != null
          ? DateTime.parse(json?['updatedAt'])
          : null,
      deletedAt: json?['deletedAt'] != null
          ? DateTime.parse(json?['deletedAt'])
          : null,
      user:
          json?['user'] != null ? PostUserModel.fromJson(json?['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'place': place,
        'latitude': latitude,
        'longtitude': longtitude,
        'userId': userId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
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
    return 'PostRequestModel(description: $description, specie: $specie, place: $place, latitude: $latitude, longitude: $longitude)';
  }
}

class PostUserModel {
  final String id;
  final String name;
  final String? userName;
  final String email;
  final String profileImage;

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
      profileImage: json['profileImage'] ?? '',
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
