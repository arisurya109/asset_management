// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationTemplateUseCase {
  FindAllPreparationTemplateUseCase(this._repository);

  final MasterRepository _repository;

  Future<Either<Failure, List<PreparationTemplate>>> call() async {
    return _repository.findAllPreparationTemplate();
  }
}
