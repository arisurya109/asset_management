// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class FindAllLocationUseCase {
  FindAllLocationUseCase(this._repository);

  final LocationRepository _repository;

  Future<Either<Failure, List<Location>>> call() async {
    return _repository.findAllLocation();
  }
}
