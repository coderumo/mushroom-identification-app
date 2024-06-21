import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static final Database _instance = Database._();
  factory Database() => _instance;
  Database._();
  late Box<String> userBox;
  late Box<String> tokenBox;
  late Box<bool> guestBox;

  Future<void> init() async {
    await Hive.initFlutter();
    userBox = await Hive.openBox('user');
    tokenBox = await Hive.openBox('token');
    guestBox = await Hive.openBox('guest');
  }

  void login(
    String token,
    // TODO: need useer get me
  ) async {
    guestBox.put('guest', false);
    tokenBox.put('token', token);
  }

  bool isGuest() {
    return guestBox.get('guest') == true;
  }

  bool isLogged() {
    return (tokenBox.get('token') != null);
    //&&( userBox.get('user') != null);
  }

  void logout() {
    tokenBox.clear();
    userBox.clear();
    guestBox.clear();
  }
}
