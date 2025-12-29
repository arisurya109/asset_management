import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_all_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_preparation_datas_state.dart';

class AddPreparationDatasCubit extends Cubit<AddPreparationDatasState> {
  final FindAllLocationUseCase _findAllLocationUseCase;
  final FindAllUserUseCase _findAllUserUseCase;
  final FindAllAssetModelUseCase _findAllAssetModelUseCase;

  AddPreparationDatasCubit(
    this._findAllLocationUseCase,
    this._findAllUserUseCase,
    this._findAllAssetModelUseCase,
  ) : super(
        AddPreparationDatasState(
          locations: [],
          approveds: [],
          workers: [],
          assetCategories: [],
          assetModels: [],
          assetTypes: [],
        ),
      );

  Future<List<AssetModel>> getAssetModelsForDropdown(
    String? type,
    String? category,
  ) async {
    if (type == null || category == null) {
      emit(state.copyWith(assetModels: []));
      return [];
    }

    final rawDatas = state.assets;

    if (rawDatas == null || rawDatas.isEmpty) {
      emit(state.copyWith(assetModels: []));
      return [];
    }

    final assetModels = rawDatas
        .where(
          (element) =>
              element.typeName == type && element.categoryName == category,
        )
        .toList();

    emit(state.copyWith(assetModels: assetModels));
    return assetModels;
  }

  Future<List<String>> getAssetCategoriesForDropdown(String? type) async {
    if (type == null) {
      emit(state.copyWith(assetCategories: []));
      return [];
    }
    final rawDatas = state.assets;

    if (rawDatas == null || rawDatas.isEmpty) {
      emit(state.copyWith(assetCategories: []));
      return [];
    }

    final List<String> distinctCategories = rawDatas
        .where((element) => element.typeName == type)
        .map((e) => e.categoryName ?? 'Uncategorized')
        .toSet()
        .toList();

    distinctCategories.sort();

    emit(state.copyWith(assetCategories: distinctCategories));
    return distinctCategories;
  }

  Future<List<String>> getAssetTypesForDropdown() async {
    final rawDatas = state.assets;

    if (rawDatas == null || rawDatas.isEmpty) {
      emit(state.copyWith(assetTypes: []));
      return [];
    }

    final List<String> distinctTypes = rawDatas
        .map((e) => e.typeName ?? 'Uncategorized')
        .toSet()
        .toList();

    distinctTypes.sort();

    emit(state.copyWith(assetTypes: distinctTypes));
    return distinctTypes;
  }

  void getAssets() async {
    final failureOrAssets = await _findAllAssetModelUseCase();

    return failureOrAssets.fold(
      (failure) {
        emit(state.copyWith(assets: []));
      },
      (assets) {
        emit(state.copyWith(assets: assets));
      },
    );
  }

  Future<List<Location>> getLocationsForDropdown() async {
    final failureOrLocations = await _findAllLocationUseCase();

    return failureOrLocations.fold(
      (_) {
        emit(state.copyWith(locations: []));
        return [];
      },
      (locations) {
        emit(state.copyWith(locations: locations));
        return locations;
      },
    );
  }

  Future<List<User>> getApprovedsForDropDown() async {
    final failureOrApproveds = await _findAllUserUseCase();

    return failureOrApproveds.fold(
      (_) {
        emit(state.copyWith(approveds: []));
        return [];
      },
      (approveds) {
        emit(state.copyWith(approveds: approveds));
        return approveds;
      },
    );
  }

  Future<List<User>> getWorkersForDropDown(User? user) async {
    if (user == null) {
      emit(state.copyWith(workers: []));
      return [];
    }
    final approveds = state.approveds ?? [];

    final workers = approveds.where((e) {
      return e != user;
    }).toList();

    emit(state.copyWith(workers: workers));
    return workers;
  }
}
