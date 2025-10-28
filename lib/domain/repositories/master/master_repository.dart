import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:dartz/dartz.dart';

abstract class MasterRepository {
  Future<Either<Failure, List<AssetType>>> findAllAssetType();
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand();
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory();
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel();
  Future<Either<Failure, List<Location>>> findAllLocation();
  Future<Either<Failure, List<Vendor>>> findAllVendor();

  Future<Either<Failure, AssetType>> createAssetType(AssetType params);
  Future<Either<Failure, AssetBrand>> createAssetBrand(AssetBrand params);
  Future<Either<Failure, AssetCategory>> createAssetCategory(
    AssetCategory params,
  );
  Future<Either<Failure, AssetModel>> createAssetModel(AssetModel params);
  Future<Either<Failure, Location>> createLocation(Location params);
  Future<Either<Failure, Vendor>> createVendor(Vendor params);

  // Preparation Template
  Future<Either<Failure, PreparationTemplate>> createPreparationTemplate(
    PreparationTemplate params,
  );

  Future<Either<Failure, List<PreparationTemplate>>>
  findAllPreparationTemplate();

  Future<Either<Failure, String>> deletePreparationTemplate(int params);

  // Preparation Template Item
  Future<Either<Failure, List<PreparationTemplateItem>>>
  createPreparationTemplateItem(
    List<PreparationTemplateItem> params,
    int templateId,
  );

  Future<Either<Failure, List<PreparationTemplateItem>>>
  findAllPreparationTemplateItemByTemplateId(int params);
}
