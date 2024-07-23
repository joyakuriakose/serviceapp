import 'package:get_storage/get_storage.dart';
import '../app.dart';
import '../model/user_model.dart';


// abstract class LocalStore {
//   static void setData(String key, dynamic value) =>
//       GetStorage().write(key, value);
//
//   static int? getInt(String key) => GetStorage().read(key);
//
//   static String? getString(String key) => GetStorage().read(key);
//
//   static bool? getBool(String key) => GetStorage().read(key);
//
//   static double? getDouble(String key) => GetStorage().read(key);
//
//   static dynamic getData(String key) => GetStorage().read(key);
//
//   static void clearData() async => GetStorage().erase();
//
//   static void setString(String key, String value) =>
//       GetStorage().write(key, value);
// }
//
// class FetchDataFromLocalStore {
//   userData() async {
//     App.user = EmployeeDetails(
//       id: LocalStore.getInt('id'),
//       apiToken: LocalStore.getString('token'),
//       name: LocalStore.getString('name'),
//       gender: LocalStore.getString('gender'),
//       dob: LocalStore.getString('dob'),
//       phone: LocalStore.getString('phone'),
//       email: LocalStore.getString('email'),
//       profilePic: LocalStore.getString('profilePic'),
//     );
//     App.token = LocalStore.getString('token') ?? '';
//   }
// }

abstract class LocalStore {
  static final storage = GetStorage();

  static void setData(String key, dynamic value) {
    storage.write(key, value);
    print('Set $key: $value');
  }

  static int? getInt(String key) {
    final value = storage.read(key);
    print('Get $key: $value');
    return value;
  }

  static String? getString(String key) {
    final value = storage.read(key);
    print('Get $key: $value');
    return value;

  }

  static bool? getBool(String key) {
    final value = storage.read(key);
    print('Get $key: $value');
    return value;
  }

  static double? getDouble(String key) {
    final value = storage.read(key);
    print('Get $key: $value');
    return value;
  }

  static dynamic getData(String key) {
    final value = storage.read(key);
    print('Get $key: $value');
    return value;
  }

  static void clearData() async {
    await storage.erase();
    print('Storage cleared');
  }

  static void setString(String key, String value) {
    storage.write(key, value);
    print('Set $key: $value');
  }
}

class FetchDataFromLocalStore {
  Future<void> userData() async {
    App.user = EmployeeDetails(
      id: LocalStore.getInt('user_id'),
      name: LocalStore.getString('name'),
      email: LocalStore.getString('email'),
      password: LocalStore.getString('password'),
      apiToken: LocalStore.getString('token'),
    );
    App.token = LocalStore.getString('token') ?? '';
    print('App.token: ${App.token}');
  }
}
