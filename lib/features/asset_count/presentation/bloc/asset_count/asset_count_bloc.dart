// ignore_for_file: depend_on_referenced_packages
import '../../../../../core/utils/enum.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/asset_count.dart';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'asset_count_event.dart';
part 'asset_count_state.dart';

class AssetCountBloc extends Bloc<AssetCountEvent, AssetCountState> {
  final FindAllAssetCountUseCase _get;
  final CreateAssetCountUseCase _create;
  final UpdateStatusAssetCountUseCase _update;
  final ExportAssetCountIdUseCase _export;

  AssetCountBloc(this._get, this._create, this._update, this._export)
    : super(AssetCountState()) {
    on<OnGetAllAssetCount>(_getAssets);
    on<OnCreateAssetCount>(_createAsset);
    on<OnUpdateStatusAssetCount>(_updateAsset);
    on<OnExportAssetCount>(_exportAsset);
    on<OnSelectedAssetCountDetail>(_selectedAsset);
  }

  void _exportAsset(
    OnExportAssetCount event,
    Emitter<AssetCountState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCount.loading));

    final failureOrPath = await _export(event.params);

    return failureOrPath.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCount.failed,
          message: failure.message,
        ),
      ),
      (path) =>
          emit(state.copyWith(status: StatusAssetCount.success, message: path)),
    );
  }

  void _selectedAsset(
    OnSelectedAssetCountDetail event,
    Emitter<AssetCountState> emit,
  ) async {
    final assetCount = state.assetsCount?.firstWhere(
      (element) => element.id == event.params,
    );

    emit(
      state.copyWith(
        status: StatusAssetCount.success,
        assetCountDetail: assetCount,
      ),
    );
  }

  void _updateAsset(
    OnUpdateStatusAssetCount event,
    Emitter<AssetCountState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCount.loading));

    final failureOrAsset = await _update(event.countId, event.params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCount.failed,
          message: failure.message,
        ),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusAssetCount.success,
          assetsCount: state.assetsCount
            ?..removeWhere((element) => element.id == event.countId)
            ..add(asset),
          assetCountDetail: asset,
        ),
      ),
    );
  }

  void _createAsset(
    OnCreateAssetCount event,
    Emitter<AssetCountState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCount.loading));

    final failureOrAsset = await _create(event.params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCount.failed,
          message: failure.message,
        ),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusAssetCount.success,
          message: 'Successfully Create Asset Count ${asset.title}',
          assetsCount: state.assetsCount?..add(asset),
        ),
      ),
    );
  }

  void _getAssets(
    OnGetAllAssetCount event,
    Emitter<AssetCountState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCount.loading));

    final failureOrAssets = await _get();

    return failureOrAssets.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCount.failed,
          message: failure.message,
        ),
      ),
      (assets) => emit(
        state.copyWith(status: StatusAssetCount.success, assetsCount: assets),
      ),
    );
  }
}
