// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterResponseModel registerResponseModelFromMap(String str) =>
    RegisterResponseModel.fromMap(json.decode(str));

String registerResponseModelToMap(RegisterResponseModel data) =>
    json.encode(data.toMap());

class RegisterResponseModel {
  final String id;
  final String name;
  final String userName;
  final String email;
  final String password;
  final dynamic profileImage;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  RegisterResponseModel({
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

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profileImage: json["profileImage"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "userName": userName,
        "email": email,
        "password": password,
        "profileImage": profileImage,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
      };
}
