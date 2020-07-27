import 'package:hive/hive.dart';

class Queries {
  Future<void> openAuthBox() async {
    await Hive.openBox('authBox');
  }

  bool get hasToken {
    return Hive.box('authBox').get('token') == true;
  }

  Future<void> deleteSettingsData() async {
    await Hive.box('authBox').clear();
  }

  void saveToken({bool token}) {
    Hive.box('authBox').put("token", token);
  }
}
