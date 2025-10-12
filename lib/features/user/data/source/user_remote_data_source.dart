import '../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(UserModel params);
  Future<void> logout();
  Future<String> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  );
  Future<UserModel> autoLogin();
}
