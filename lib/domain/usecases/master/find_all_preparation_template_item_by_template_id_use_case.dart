// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationTemplateItemByTemplateIdUseCase {
  FindAllPreparationTemplateItemByTemplateIdUseCase(this._repository);

  final MasterRepository _repository;

  Future<Either<Failure, List<PreparationTemplateItem>>> call(
    int params,
  ) async {
    return _repository.findAllPreparationTemplateItemByTemplateId(params);
  }
}
