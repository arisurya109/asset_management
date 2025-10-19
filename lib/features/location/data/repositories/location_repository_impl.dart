import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../model/location_model.dart';
import '../source/location_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._source);

  final LocationRemoteDataSource _source;

  @override
  Future<Either<Failure, Location>> createLocation(Location params) async {
    try {
      final response = await _source.createLocation(
        LocationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> findAllLocation() async {
    try {
      final response = await _source.findAllLocation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
