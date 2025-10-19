// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/asset_model/domain/entities/asset_model.dart';
import 'package:asset_management/features/asset_model/domain/usecases/create_asset_model_use_case.dart';
import 'package:asset_management/features/asset_model/domain/usecases/find_all_asset_model_use_case.dart';

part 'asset_model_event.dart';
part 'asset_model_state.dart';

class AssetModelBloc extends Bloc<AssetModelEvent, AssetModelState> {
  final FindAllAssetModelUseCase _findAllAssetModelUseCase;
  final CreateAssetModelUseCase _createAssetModelUseCase;

  AssetModelBloc(this._findAllAssetModelUseCase, this._createAssetModelUseCase)
    : super(AssetModelState()) {
    on<OnCreateAssetModel>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final failureOrAssets = await _createAssetModelUseCase(event.params);

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetModel.failed,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(
            status: StatusAssetModel.success,
            assets: state.assets?..add(assets),
          ),
        ),
      );
    });

    on<OnGetAllAssetModel>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final failureOrAssets = await _findAllAssetModelUseCase();

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetModel.failed,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(status: StatusAssetModel.success, assets: assets),
        ),
      );
    });
  }
}
