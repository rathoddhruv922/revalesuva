// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class LocalStorage {
//   //singleton setup
//   static final LocalStorage instance = LocalStorage._internal();
//
//   factory LocalStorage() {
//     return instance;
//   }
//
//   LocalStorage._internal();
//
//   final _secureStorage = const FlutterSecureStorage();
//
//   //setup
//   final AndroidOptions _getAndroidOptions = const AndroidOptions(
//     encryptedSharedPreferences: true,
//     sharedPreferencesName: "cause-i",
//   );
//   final IOSOptions _getIosOptions = const IOSOptions(
//     accessibility: KeychainAccessibility.first_unlock,
//     accountName: "cause-i",
//   );
//
//   //Storage Key
//
//   final String _verificationToken = "verificationToken";
//   final String _authenticationToken = "authenticationToken";
//
//   //Methods
//   setVerificationToken(String? s) async {
//     await _secureStorage.write(
//       key: _verificationToken,
//       value: s ?? "",
//       aOptions: _getAndroidOptions,
//       iOptions: _getIosOptions,
//     );
//   }
//
//   Future<String> getVerificationToken() async {
//     String readData = await _secureStorage.read(
//           key: _verificationToken,
//           aOptions: _getAndroidOptions,
//           iOptions: _getIosOptions,
//         ) ??
//         "";
//     return readData;
//   }
//
//   setAuthenticationToken(String? s) async {
//     await _secureStorage.write(
//       key: _authenticationToken,
//       value: s ?? "",
//       aOptions: _getAndroidOptions,
//       iOptions: _getIosOptions,
//     );
//   }
//
//   Future<String> getAuthenticationToken() async {
//     String readData = await _secureStorage.read(
//       key: _authenticationToken,
//       aOptions: _getAndroidOptions,
//       iOptions: _getIosOptions,
//     ) ??
//         "";
//     return readData;
//   }
//
//   clearData() async {
//     await _secureStorage.deleteAll(aOptions: _getAndroidOptions, iOptions: _getIosOptions);
//   }
// }
