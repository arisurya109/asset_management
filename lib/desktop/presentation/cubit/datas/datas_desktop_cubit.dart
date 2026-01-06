import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_by_storage_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_type_use_case.dart';
import 'package:bloc/bloc.dart';

class DatasDesktopCubit extends Cubit<void> {
  final FindLocationByStorageUseCase _findLocationByStorageUseCase;
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;
  final FindLocationTypeUseCase _findLocationTypeUseCase;
  final FindAllLocationUseCase _findAllLocationUseCase;

  DatasDesktopCubit(
    this._findLocationByStorageUseCase,
    this._findAssetByQueryUseCase,
    this._findLocationTypeUseCase,
    this._findAllLocationUseCase,
  ) : super('');

  Future<List<String>> getLocationTypes() async {
    final failureOrTypes = await _findLocationTypeUseCase();

    return failureOrTypes.fold((_) => [], (types) => types);
  }

  Future<List<Location>> getLocations() async {
    final failureOrTypes = await _findAllLocationUseCase();

    return failureOrTypes.fold((_) => [], (locations) => locations);
  }

  Future<List<Location>> getLocationsByStorage(String params) async {
    final failureOrLocations = await _findLocationByStorageUseCase(params);

    return failureOrLocations.fold((_) => [], (locations) => locations);
  }

  Future<AssetEntity?> getAssetByAssetCode(String params) async {
    final failureOrAssets = await _findAssetByQueryUseCase(params: params);

    return failureOrAssets.fold(
      (_) => null,
      (assets) =>
          assets.where((element) => element.assetCode == params).firstOrNull,
    );
  }
}
