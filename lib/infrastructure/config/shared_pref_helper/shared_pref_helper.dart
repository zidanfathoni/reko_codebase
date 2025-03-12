import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _accessToken = 'access_token';
  static const String _userId = 'user_id';
  static const String _username = 'username';
  static const String _roleId = 'role_id';
  static const String _roleType = 'role_type';
  static const String _isLogin = 'is_login';
  static const String _lightThemeKey = 'is_theme_light';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ??
      true; // todo set the default theme (true for light, false for dark)
  /// generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  /// authorization token
  static Future<void> setAccessToken(String token) =>
      _sharedPreferences.setString(_accessToken, token);
  static String? getAccessToken() => _sharedPreferences.getString(_accessToken);

  /// user id
  static Future<void> setUserId(int id) => _sharedPreferences.setInt(_userId, id);
  static int? getUserId() => _sharedPreferences.getInt(_userId);

  /// username
  static Future<void> setUsername(String username) =>
      _sharedPreferences.setString(_username, username);
  static String? getUsername() => _sharedPreferences.getString(_username);

  /// role id
  static Future<void> setRoleId(int id) => _sharedPreferences.setInt(_roleId, id);
  static int? getRoleId() => _sharedPreferences.getInt(_roleId);

  /// role type
  static Future<void> setRoleType(String type) => _sharedPreferences.setString(_roleType, type);
  static String? getRoleType() => _sharedPreferences.getString(_roleType);

  /// is user login
  static Future<void> setIsLogin(bool isLogin) => _sharedPreferences.setBool(_isLogin, isLogin);
  static bool? getIsLogin() => _sharedPreferences.getBool(_isLogin);

  /// check is user login
  static bool isLogin() => _sharedPreferences.getBool(_isLogin) ?? false;

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();
}
