import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation_item/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationItemByPreparationIdUseCase {
  final PreparationItemRepository _repository;

  FindAllPreparationItemByPreparationIdUseCase(this._repository);

  Future<Either<Failure, List<PreparationItem>>> call({required int id}) async {
    return _repository.findAllPreparationItemByPreparationId(id: id);
  }
}
