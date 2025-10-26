import '../../model/user/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> createUser(UserModel params);
  Future<List<UserModel>> findAllUser();
  Future<UserModel> updateUser(UserModel params);
  Future<String> deleteUser(int params);
  Future<UserModel> findUserById(int params);
}
