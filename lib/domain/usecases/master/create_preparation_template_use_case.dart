// ignore_for_file: public_member_api_docs

import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/core.dart';

class CreatePreparationTemplateUseCase {
  CreatePreparationTemplateUseCase(this._repository);

  final MasterRepository _repository;

  Future<Either<Failure, PreparationTemplate>> call(
    PreparationTemplate params,
  ) async {
    return _repository.createPreparationTemplate(params);
  }
}
