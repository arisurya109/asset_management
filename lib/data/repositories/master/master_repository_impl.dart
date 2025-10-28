import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/master/asset_brand_model.dart';
import 'package:asset_management/data/model/master/asset_category_model.dart';
import 'package:asset_management/data/model/master/asset_model_model.dart';
import 'package:asset_management/data/model/master/asset_type_model.dart';
import 'package:asset_management/data/model/master/location_model.dart';
import 'package:asset_management/data/model/master/preparation_template_item_model.dart';
import 'package:asset_management/data/model/master/preparation_template_model.dart';
import 'package:asset_management/data/model/master/vendor_model.dart';
import 'package:asset_management/data/source/master/master_remote_data_source.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class MasterRepositoryImpl implements MasterRepository {
  final MasterRemoteDataSource _source;

  MasterRepositoryImpl(this._source);

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
  Future<Either<Failure, Location>> createLocation(Location params) async {
    try {
      final response = await _source.createLocation(
        LocationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vendor>> createVendor(Vendor params) async {
    try {
      final response = await _source.createVendor(
        VendorModel.fromEntity(params),
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
  Future<Either<Failure, List<Location>>> findAllLocation() async {
    try {
      final response = await _source.findAllLocation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> findAllVendor() async {
    try {
      final response = await _source.findAllVendor();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate(
    PreparationTemplate params,
  ) async {
    try {
      final response = await _source.createPreparationTemplate(
        PreparationTemplateModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
  createPreparationTemplateItem(
    List<PreparationTemplateItem> params,
    int templateId,
  ) async {
    try {
      final response = await _source.createPreparationTemplateItem(
        params.map(PreparationTemplateItemModel.fromEntity).toList(),
        templateId,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationTemplate(int params) async {
    try {
      final response = await _source.deletePreparationTemplate(params);
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplate>>>
  findAllPreparationTemplate() async {
    try {
      final response = await _source.findAllPreparationTemplate();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationTemplateItem>>>
  findAllPreparationTemplateItemByTemplateId(int params) async {
    try {
      final response = await _source.findAllPreparationTemplateItemByTemplateId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
