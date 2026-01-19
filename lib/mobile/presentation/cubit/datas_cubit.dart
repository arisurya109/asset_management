// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_type_use_case.dart';
import 'package:bloc/bloc.dart';

import 'package:asset_management/domain/usecases/master/find_all_asset_brand_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_type_use_case.dart';

class DatasCubit extends Cubit<void> {
  final FindAllAssetTypeUseCase _findAllAssetTypeUseCase;
  final FindAllAssetBrandUseCase _findAllAssetBrandUseCase;
  final FindAllAssetCategoryUseCase _findAllAssetCategoryUseCase;
  final FindAllAssetModelUseCase _findAllAssetModelUseCase;
  final FindAllLocationUseCase _findAllLocationUseCase;
  final FindLocationTypeUseCase _findLocationTypeUseCase;
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;

  DatasCubit(
    this._findAllAssetTypeUseCase,
    this._findAllAssetBrandUseCase,
    this._findAllAssetCategoryUseCase,
    this._findAllAssetModelUseCase,
    this._findAllLocationUseCase,
    this._findLocationTypeUseCase,
    this._findAssetByQueryUseCase,
  ) : super([]);

  Future<List<Location>> getLocationsPicking() async {
    final failureOrTypes = await _findAllLocationUseCase();

    return failureOrTypes.fold(
      (_) => [],
      (locations) => locations
          .where(
            (element) =>
                element.locationType == 'RACK' || element.locationType == 'BOX',
          )
          .toList(),
    );
  }

  Future<List<AssetEntity>> getAssetByLocation(String params) async {
    final failureOrAsset = await _findAssetByQueryUseCase(params: params);

    return failureOrAsset.fold(
      (_) => [],
      (assets) =>
          assets.where((element) => element.locationDetail == params).toList(),
    );
  }

  Future<AssetEntity?> getAssetByQuery(String params) async {
    final failureOrAsset = await _findAssetByQueryUseCase(params: params);

    return failureOrAsset.fold(
      (_) => null,
      (assets) =>
          assets.where((element) => element.assetCode == params).firstOrNull,
    );
  }

  Future<List<String>> getLocationTypes() async {
    final failureOrTypes = await _findLocationTypeUseCase();

    return failureOrTypes.fold((_) => [], (types) => types);
  }

  Future<List<Location>> getLocations() async {
    final failureOrTypes = await _findAllLocationUseCase();

    return failureOrTypes.fold((_) => [], (locations) => locations);
  }

  Future<List<AssetType>> getAssetTypes() async {
    final failureOrTypes = await _findAllAssetTypeUseCase();

    return failureOrTypes.fold((_) => [], (types) => types);
  }

  Future<List<AssetBrand>> getAssetBrands() async {
    final failureOrBrands = await _findAllAssetBrandUseCase();

    return failureOrBrands.fold((_) => [], (brands) => brands);
  }

  Future<List<AssetCategory>> getAssetCategories() async {
    final failureOrCategories = await _findAllAssetCategoryUseCase();

    return failureOrCategories.fold((_) => [], (categories) => categories);
  }

  Future<List<AssetModel>> getAssetModels() async {
    final failureOrModels = await _findAllAssetModelUseCase();

    return failureOrModels.fold((_) => [], (models) => models);
  }
}
