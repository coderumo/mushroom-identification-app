import 'dart:convert';

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
  final bool canEat; // Yeni alan
  final String trueLabels; // Yeni alan

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
    required this.canEat, // Yeni alan
    required this.trueLabels, // Yeni alan
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
      canEat: json?['canEat'] ?? false, // Yeni alan
      trueLabels: json?['true_labels'] ?? '', // Yeni alan
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
        'canEat': canEat,
        'true_labels': trueLabels,
      };

  String time(DateTime? time) {
    if (time == null) return '';
    return "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}";
  }
}

/*{
                          'description': descriptionController.text,
                          'specie': specieController.text,
                          'place': konum,
                          'latitude': latitude,
                          'longitude': longitude,
                         
                        };*/

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
