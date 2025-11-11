import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationItemByPreparationIdUseCase {
  final PreparationRepository _repository;

  FindAllPreparationItemByPreparationIdUseCase(this._repository);

  Future<Either<Failure, List<PreparationItem>>> call(int params) async {
    return _repository.findAllPreparationItemByPreparationId(params);
  }
}
