// import 'package:base_getx/src/const/config.dart';
//
// class StorageApp {
//   static final _singleton = StorageApp._internal();
//
//   factory StorageApp() {
//     return _singleton;
//   }
//
//   StorageApp._internal();
//
//   static final _storage = FlutterSecureStorage();
//
//   static Future<String> getTokenAuthen() async {
//     String token = await _storage.read(key: KEY_TOKEN_AUTHEN) ?? '';
//     return token;
//   }
//
//   static Future<String> getTokenFirebase() async {
//     String token = await _storage.read(key: KEY_TOKEN_FIREBASE) ?? '';
//     return token;
//   }
//
//   static Future<void> setTokenAuthen(String value) async {
//     await _storage.write(key: KEY_TOKEN_AUTHEN, value: value);
//   }
//
//   static Future<void> setTokenFirebase(String value) async {
//     await _storage.write(key: KEY_TOKEN_FIREBASE, value: value);
//   }
//
//   static Future<void> deleteAllStorage() async {
//     await _storage.deleteAll();
//   }
// }
