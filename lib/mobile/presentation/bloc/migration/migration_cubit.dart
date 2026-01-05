import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/asset/migration_asset_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'migration_state.dart';

class MigrationCubit extends Cubit<MigrationState> {
  final FindAllAssetCategoryUseCase _findAllAssetCategoryUseCase;
  final FindAllAssetModelUseCase _findAllAssetModelUseCase;
  final FindAllLocationUseCase _findAllLocationUseCase;
  final MigrationAssetUseCase _migrationAssetUseCase;
  MigrationCubit(
    this._findAllAssetCategoryUseCase,
    this._findAllAssetModelUseCase,
    this._findAllLocationUseCase,
    this._migrationAssetUseCase,
  ) : super(MigrationState());

  void onMigrateAsset(AssetEntity params) async {
    emit(state.copyWith(status: StatusMigration.loading));

    final failureOrAsset = await _migrationAssetUseCase(params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusMigration.failure,
          message: failure.message,
        ),
      ),
      (asset) =>
          emit(state.copyWith(status: StatusMigration.success, asset: asset)),
    );
  }

  Future<List<Location>> getLocations() async {
    final failureOrTypes = await _findAllLocationUseCase();

    return failureOrTypes.fold((_) => [], (locations) => locations);
  }

  Future<List<AssetCategory>> getAssetCategories() async {
    final failureOrCategories = await _findAllAssetCategoryUseCase();

    return failureOrCategories.fold((_) => [], (categories) => categories);
  }

  Future<List<AssetModel>> getAssetModels(String params) async {
    final failureOrModels = await _findAllAssetModelUseCase();

    return failureOrModels.fold(
      (_) => [],
      (models) =>
          models.where((element) => element.categoryName == params).toList(),
    );
  }
}
