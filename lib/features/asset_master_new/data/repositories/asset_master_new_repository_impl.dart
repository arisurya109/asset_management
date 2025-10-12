import 'package:dartz/dartz.dart';

import '../models/asset_category_model.dart';
import '../models/asset_model_model.dart';
import '../models/asset_type_model.dart';
import '../models/asset_brand_model.dart';
import '../source/asset_master_remote_data_source.dart';
import '../../domain/entities/asset_brand.dart';
import '../../domain/entities/asset_category.dart';
import '../../domain/entities/asset_model.dart';
import '../../domain/entities/asset_type.dart';
import '../../domain/repositories/asset_master_new_repository.dart';
import '../../../../core/core.dart';

class AssetMasterNewRepositoryImpl implements AssetMasterNewRepository {
  final AssetMasterRemoteDataSource _source;

  AssetMasterNewRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetBrand>> createAssetBrand(
    AssetBrand params,
  ) async {
    try {
      final response = await _source.createAssetBrand(
        AssetBrandModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCategory>> createAssetCategory(
    AssetCategory params,
  ) async {
    try {
      final response = await _source.createAssetCategory(
        AssetCategoryModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetModel>> createAssetModel(
    AssetModel params,
  ) async {
    try {
      final response = await _source.createAssetModel(
        AssetModelModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> createAssetType(AssetType params) async {
    try {
      final response = await _source.createAssetType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand() async {
    try {
      final response = await _source.findAllAssetBrand();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory() async {
    try {
      final response = await _source.findAllAssetCategory();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel() async {
    try {
      final response = await _source.findAllAssetModel();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetType>>> findAllAssetType() async {
    try {
      final response = await _source.findAllAssetType();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetBrand>> findByIdAssetBrand(int params) async {
    try {
      final response = await _source.findByIdAssetBrand(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCategory>> findByIdAssetCategory(
    int params,
  ) async {
    try {
      final response = await _source.findByIdAssetCategory(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetModel>> findByIdAssetModel(int params) async {
    try {
      final response = await _source.findByIdAssetModel(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> findByIdAssetType(int params) async {
    try {
      final response = await _source.findByIdAssetType(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetBrand>> updateAssetBrand(
    AssetBrand params,
  ) async {
    try {
      final response = await _source.updateAssetBrand(
        AssetBrandModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCategory>> updateAssetCategory(
    AssetCategory params,
  ) async {
    try {
      final response = await _source.updateAssetCategory(
        AssetCategoryModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetModel>> updateAssetModel(
    AssetModel params,
  ) async {
    try {
      final response = await _source.updateAssetModel(
        AssetModelModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetType>> updateAssetType(AssetType params) async {
    try {
      final response = await _source.updateAssetType(
        AssetTypeModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
