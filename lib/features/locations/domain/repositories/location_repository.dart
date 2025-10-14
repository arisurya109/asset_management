// ignore_for_file: public_member_api_docs
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/location.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<Location>>> findAllLocation();
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, Location>> updateLocation(Location params);
}
