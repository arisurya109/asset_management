import 'package:asset_management/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ReprintRepository {
  Future<Either<Failure, Map<String, dynamic>>> reprintAssetOrLocation({
    required String params,
    required String type,
  });
}
