import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/location/domain/entities/location.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, List<Location>>> findAllLocation();
}
