import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location_pagination.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindLocationByPaginationUseCase {
  final MasterRepository _repository;

  FindLocationByPaginationUseCase(this._repository);

  Future<Either<Failure, LocationPagination>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findLocationByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
