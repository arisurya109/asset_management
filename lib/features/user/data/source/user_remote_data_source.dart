import 'package:asset_management/features/user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(String username, String password);
  Future<UserModel> autoLogin();
  Future<void> logout();
}
