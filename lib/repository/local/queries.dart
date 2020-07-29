import 'package:hive/hive.dart';

class Queries {
  Future<void> openAuthBox() async {
    await Hive.openBox('authBox');
  }

  void saveToken({bool token}) {
    Hive.box('authBox').put("token", token);
  }

  void saveName({String name}) {
    Hive.box('authBox').put("username", name);
  }

  bool get hasToken {
    return Hive.box('authBox').get('token') == true;
  }

  String get username {
    return Hive.box('authBox').get('username');
  }

  Future<void> deleteAuthData() async {
    await Hive.box('authBox').clear();
  }
}
