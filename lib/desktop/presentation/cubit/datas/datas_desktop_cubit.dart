import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_by_storage_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_type_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/get_preparation_types_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_all_user_use_case.dart';
import 'package:bloc/bloc.dart';

class DatasDesktopCubit extends Cubit<void> {
  final FindLocationByStorageUseCase _findLocationByStorageUseCase;
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;
  final FindLocationTypeUseCase _findLocationTypeUseCase;
  final FindAllLocationUseCase _findAllLocationUseCase;
  final GetPreparationTypesUseCase _getPreparationTypesUseCase;
  final FindAllUserUseCase _findAllUserUseCase;

  DatasDesktopCubit(
    this._findLocationByStorageUseCase,
    this._findAssetByQueryUseCase,
    this._findLocationTypeUseCase,
    this._findAllLocationUseCase,
    this._getPreparationTypesUseCase,
    this._findAllUserUseCase,
  ) : super('');

  Future<List<User>> findAllUser(String? username) async {
    if (username != null) {
      final failureOrUsers = await _findAllUserUseCase();

      return failureOrUsers.fold(
        (_) => [],
        (users) =>
            users.where((element) => element.username != username).toList(),
      );
    } else {
      final failureOrUsers = await _findAllUserUseCase();

      return failureOrUsers.fold((_) => [], (users) => users);
    }
  }

  Future<List<Location>> findLocationPreparationByTypes(String? types) async {
    final failureOrLocations = await _findLocationByStorageUseCase(
      'NON STORAGE',
    );

    return failureOrLocations.fold((_) => [], (locations) {
      final locationInternal = locations
          .where((e) => e.locationType != 'VENDOR')
          .toList();
      final locationExternal = locations
          .where((e) => e.locationType == 'VENDOR')
          .toList();
      if (types == 'INTERNAL') {
        return locationInternal;
      } else {
        return locationExternal;
      }
    });
  }

  Future<List<String>> getPreparationTypes() async {
    final failureOrTypes = await _getPreparationTypesUseCase();

    return failureOrTypes.fold((_) => [], (types) => types);
  }

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
