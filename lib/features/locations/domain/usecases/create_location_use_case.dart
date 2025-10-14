// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class CreateLocationUseCase {
  CreateLocationUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, Location>> call(Location params) async {
    return _repository.createLocation(params);
  }
}
