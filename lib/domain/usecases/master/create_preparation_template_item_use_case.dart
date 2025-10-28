// ignore_for_file: public_member_api_docs

import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/core.dart';

class CreatePreparationTemplateItemUseCase {
  CreatePreparationTemplateItemUseCase(this._repository);

  final MasterRepository _repository;

  Future<Either<Failure, List<PreparationTemplateItem>>> call(
    List<PreparationTemplateItem> params,
    int templateId,
  ) async {
    return _repository.createPreparationTemplateItem(params, templateId);
  }
}
