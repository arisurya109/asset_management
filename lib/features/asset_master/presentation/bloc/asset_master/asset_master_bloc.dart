// ignore_for_file: depend_on_referenced_packages

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/asset_master.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'asset_master_event.dart';
part 'asset_master_state.dart';

class AssetMasterBloc extends Bloc<AssetMasterEvent, AssetMasterState> {
  final FindAllAssetMasterUseCase _findAll;
  final InsertAssetMasterUseCase _insert;
  final UpdateAssetMasterUseCase _update;

  AssetMasterBloc(this._findAll, this._insert, this._update)
    : super(AssetMasterState()) {
    on<OnSelectedAssetMaster>((event, emit) {
      emit(state.copyWith(asset: event.params));
    });

    on<OnInsertAssetMaster>((event, emit) async {
      emit(state.copyWith(status: StatusAssetMaster.loading));

      final failureOrAsset = await _insert(event.params);

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetMaster.failed,
            message: failure.message,
          ),
        ),
        (asset) => emit(
          state.copyWith(
            status: StatusAssetMaster.success,
            assets: state.assets?..add(asset),
            message: 'Successfully insert ${asset.name}',
          ),
        ),
      );
    });

    on<OnFindAllAssetMaster>((event, emit) async {
      emit(state.copyWith(status: StatusAssetMaster.loading));

      final failureOrAssets = await _findAll();

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetMaster.failed,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(status: StatusAssetMaster.success, assets: assets),
        ),
      );
    });

    on<OnUpdateAssetMaster>((event, emit) async {
      emit(state.copyWith(status: StatusAssetMaster.loading));

      final failureOrAsset = await _update(event.params);

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetMaster.failed,
            message: failure.message,
          ),
        ),
        (asset) => emit(
          state.copyWith(
            status: StatusAssetMaster.success,
            message: 'Successfully update asset ${asset.name}',
            assets: state.assets
              ?..removeWhere((element) => element.id == asset.id)
              ..add(asset)
              ..sort((a, b) => a.id!.compareTo(b.id!)),
          ),
        ),
      );
    });
  }
}
