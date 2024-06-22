import 'package:hive_flutter/hive_flutter.dart';
import 'package:tez_front/models/user_model.dart'; // UserModel import edildi

class Database {
  static final Database instance = Database._();
  factory Database() => instance;
  Database._();

  late Box<String> tokenBox;
  late Box<bool> guestBox;
  late Box<UserModel> userBox; // UserModel için Box ekleniyor

  Future<void> init() async {
    await Hive.initFlutter();
    tokenBox = await Hive.openBox('token');
    guestBox = await Hive.openBox('guest');
    userBox =
        await Hive.openBox<UserModel>('user'); // UserModel için Box açılıyor
  }

  void login(String token, UserModel user) {
    guestBox.put('guest', false);
    tokenBox.put('token', token);
    userBox.put('user', user); // Kullanıcı bilgileri kaydediliyor
  }

  bool isGuest() {
    return guestBox.get('guest') == true;
  }

  bool isLogged() {
    return tokenBox.get('token') != null;
  }

  void logout() {
    tokenBox.clear();
    userBox.clear(); // Kullanıcı bilgilerini temizle
    guestBox.clear();
  }

  UserModel? getUser() {
    return userBox.get('user'); // Kayıtlı kullanıcı bilgisini getir
  }
}
