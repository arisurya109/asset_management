import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation_detail/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusPreparationDetailUseCase {
  final PreparationDetailRepository _repository;

  UpdateStatusPreparationDetailUseCase(this._repository);

  Future<Either<Failure, PreparationDetail>> call({
    required int id,
    required String params,
  }) async {
    return _repository.updateStatusPreparationDetail(id: id, params: params);
  }
}
