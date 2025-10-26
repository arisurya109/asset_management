import 'package:asset_management/data/model/authentication/authentication_model.dart';
import 'package:asset_management/data/model/user/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserModel> login(AuthenticationModel params);
  Future<UserModel> autoLogin();
  Future<void> logout();
  Future<String> changePassword(AuthenticationModel params);
}
