// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/asset/asset_entity_pagination.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetByPaginationUseCase {
  FindAssetByPaginationUseCase(this._repository);

  final AssetRepository _repository;

  Future<Either<Failure, AssetEntityPagination>> call({
    required int page,
    required int limit,
    String? query,
  }) async {
    return _repository.findAssetByPagination(
      page: page,
      limit: limit,
      query: query,
    );
  }
}
