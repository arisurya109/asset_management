import 'dart:io';

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class GetDocumentPreparationByIdUseCase {
  final PreparationRepository _repository;

  GetDocumentPreparationByIdUseCase(this._repository);

  Future<Either<Failure, File>> call(int params) async {
    return _repository.getDocumentPreparationById(params);
  }
}
