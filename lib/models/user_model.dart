class UserModel {
  String? name;
  String? userName;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.userName,
    this.email,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
