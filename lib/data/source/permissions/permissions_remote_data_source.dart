import '../../model/permissions/permissions_model.dart';

abstract class PermissionsRemoteDataSource {
  Future<List<PermissionsModel>> findAllPermissions();
}
