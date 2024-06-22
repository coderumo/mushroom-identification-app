class UserModel {
  String? id;
  String? name;
  String? userName;
  String? email;
  String? password;
  String? profileImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  UserModel({
    this.id,
    this.name,
    this.userName,
    this.email,
    this.password,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    profileImage = json['profileImage'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    deletedAt =
        json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['profileImage'] = profileImage;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['deletedAt'] = deletedAt?.toIso8601String();
    return data;
  }
}
