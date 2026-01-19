// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationDetailUseCase {
  DeletePreparationDetailUseCase(this._repository);

  final PreparationDetailRepository _repository;

  Future<Either<Failure, String>> call({
    required int id,
    required int preparationId,
  }) async {
    return _repository.deletePreparationDetail(
      id: id,
      preparationId: preparationId,
    );
  }
}
