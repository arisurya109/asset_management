// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationByCodeOrDestinationUseCase {
  FindPreparationByCodeOrDestinationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, List<Preparation>>> call({
    required String params,
  }) async {
    return _repository.findPreparationByCodeOrDestination(params: params);
  }
}
