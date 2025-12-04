import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation_item/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationItemUseCase {
  final PreparationItemRepository _repository;

  CreatePreparationItemUseCase(this._repository);

  Future<Either<Failure, PreparationItem>> call({
    required PreparationItem params,
  }) async {
    return _repository.createPreparationItem(params: params);
  }
}
