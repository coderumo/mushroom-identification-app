class UserModel {
  String? id;
  String? name;
  String? userName;
  String? email;
  String? password;
  String? profileImage;

  UserModel({
    this.id,
    this.name,
    this.userName,
    this.email,
    this.password,
    this.profileImage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    data['profileImage'] = profileImage;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, userName: $userName, email: $email, password: $password, profileImage: $profileImage}';
  }
}
