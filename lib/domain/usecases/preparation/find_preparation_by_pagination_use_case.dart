import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationByPaginationUseCase {
  final PreparationRepository _repository;

  FindPreparationByPaginationUseCase(this._repository);

  Future<Either<Failure, PreparationPagination>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findPreparationByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
