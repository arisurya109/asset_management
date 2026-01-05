import 'package:asset_management/data/model/movement/movement_model.dart';

abstract class MovementRemoteDataSource {
  Future<String> createMovement(MovementModel params);
}
