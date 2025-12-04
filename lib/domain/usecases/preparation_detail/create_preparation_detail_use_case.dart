import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation_detail/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationDetailUseCase {
  final PreparationDetailRepository _repository;

  CreatePreparationDetailUseCase(this._repository);

  Future<Either<Failure, PreparationDetail>> call({
    required PreparationDetail params,
  }) async {
    return _repository.createPreparationDetail(params: params);
  }
}
