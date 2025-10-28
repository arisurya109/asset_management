// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationTemplateUseCase {
  DeletePreparationTemplateUseCase(this._repository);

  final MasterRepository _repository;

  Future<Either<Failure, String>> call(int params) async {
    return _repository.deletePreparationTemplate(params);
  }
}
