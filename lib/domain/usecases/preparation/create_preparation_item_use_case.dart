import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationItemUseCase {
  final PreparationRepository _repository;

  CreatePreparationItemUseCase(this._repository);

  Future<Either<Failure, PreparationItem>> call(PreparationItem params) async {
    return _repository.createPreparationItem(params);
  }
}
