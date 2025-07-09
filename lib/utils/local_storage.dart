import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();

  factory LocalStorage() {
    return instance;
  }

  LocalStorage._internal();

  SharedPreferences? _preferencesInstance;

  final String _authenticationToken = "authenticationToken";
  final String _userDetail = "userDetail";
  final String _isUserPlan = "userPlan";
  final String _isUserProgram = "userProgram";
  final String _userRole = "userRole";

  SharedPreferences get prefs {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
  }

  //VerificationToken
  Future<bool> setAuthToken(String? s) async {
    return prefs.setString(_authenticationToken, s ?? "");
  }

  String getAuthToken() {
    String stringValue = prefs.getString(_authenticationToken) ?? "";
    return stringValue;
  }

  //User Data
  Future<bool> setUserData(String? s) async {
    return prefs.setString(_userDetail, s ?? "");
  }

  String getUserData() {
    String stringValue = prefs.getString(_userDetail) ?? "";
    return stringValue;
  }

  //User Plan
  Future<bool> setIsUserPlan(bool? s) async {
    return prefs.setBool(_isUserPlan, s ?? false);
  }

  bool getIsUserPlan() {
    bool value = prefs.getBool(_isUserPlan) ?? false;
    return value;
  }

  //User program
  Future<bool> setIsUserProgram(bool? s) async {
    return prefs.setBool(_isUserProgram, s ?? false);
  }

  bool getIsUserProgram() {
    bool value = prefs.getBool(_isUserProgram) ?? false;
    return value;
  }

  //VerificationToken
  Future<bool> setUserRole(String? s) async {
    return prefs.setString(_userRole, s ?? "");
  }

  String getUserRole() {
    String stringValue = prefs.getString(_userRole) ?? "";
    return stringValue;
  }

  clearData() async {
    return prefs.clear();
  }
}
