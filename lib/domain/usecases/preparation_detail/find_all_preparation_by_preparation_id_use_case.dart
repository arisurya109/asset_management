import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation_detail/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationDetailByPreparationIdUseCase {
  final PreparationDetailRepository _repository;

  FindAllPreparationDetailByPreparationIdUseCase(this._repository);

  Future<Either<Failure, List<PreparationDetail>>> call({
    required int id,
  }) async {
    return _repository.findAllPreparationDetailByPreparationId(id: id);
  }
}
