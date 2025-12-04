import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/repositories/preparation_item/preparation_item_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePreparationItemUseCase {
  final PreparationItemRepository _repository;

  DeletePreparationItemUseCase(this._repository);

  Future<Either<Failure, String>> call({required int id}) async {
    return _repository.deletePreparationItem(id: id);
  }
}
