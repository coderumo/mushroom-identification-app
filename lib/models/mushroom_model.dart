import 'dart:convert';

MushroomModel mushroomModelFromJson(String str) =>
    MushroomModel.fromJson(json.decode(str));

String mushroomModelToJson(MushroomModel data) => json.encode(data.toJson());

class MushroomModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  MushroomModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory MushroomModel.fromJson(Map<String, dynamic> json) => MushroomModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
