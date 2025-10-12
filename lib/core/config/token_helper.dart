import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenHelper {
  Future<String?> getToken();
  Future<bool> saveToken(String params);
  Future<bool> removeToken();
}

class TokenHelperImpl implements TokenHelper {
  final SharedPreferences _preferences;

  TokenHelperImpl(this._preferences);

  @override
  Future<String?> getToken() async {
    return _preferences.getString('token');
  }

  @override
  Future<bool> removeToken() async {
    return await _preferences.remove('token');
  }

  @override
  Future<bool> saveToken(String params) async {
    return await _preferences.setString('token', params);
  }
}
