import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/usecases/asset/create_asset_transfer_use_case.dart';
import 'package:asset_management/domain/usecases/asset/create_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_all_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_detail_by_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final CreateAssetUseCase _createAssetUseCase;
  final FindAllAssetUseCase _findAllAssetUseCase;
  final FindAssetDetailByIdUseCase _findAssetDetailByIdUseCase;
  final CreateAssetTransferUseCase _createAsseTransferUseCase;

  AssetBloc(
    this._createAssetUseCase,
    this._findAllAssetUseCase,
    this._findAssetDetailByIdUseCase,
    this._createAsseTransferUseCase,
  ) : super(AssetState()) {
    on<OnCreateAssetsEvent>(_createAsset);
    on<OnFindAllAssetEvent>(_findAllAsset);
    on<OnFindAssetDetailEvent>(_findDetailAsset);
    on<OnCreateAssetTransferEvent>(_createAssetTransfer);
  }

  void _createAssetTransfer(
    OnCreateAssetTransferEvent event,
    Emitter<AssetState> emit,
  ) async {
    emit(state.copyWith(status: StatusAsset.loading));

    final failureOrAsset = await _createAsseTransferUseCase(
      assetId: event.assetId,
      fromLocationId: event.fromLocationId,
      movementType: event.movementType,
      toLocationId: event.toLocationId,
      quantity: event.quantity!,
      notes: event.notes,
    );

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(status: StatusAsset.failed, message: failure.message),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusAsset.success,
          assets: state.assets
            ?..removeWhere((element) => element.id == asset.id)
            ..add(asset),
        ),
      ),
    );
  }

  void _createAsset(OnCreateAssetsEvent event, Emitter<AssetState> emit) async {
    emit(state.copyWith(status: StatusAsset.loading));

    final failureOrAsset = await _createAssetUseCase(event.params);

    print(event.params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(status: StatusAsset.failed, message: failure.message),
      ),
      (asset) {
        print(asset.toString());
        emit(
          state.copyWith(
            response: asset,
            status: StatusAsset.success,
            assets: [...?state.assets, asset],
          ),
        );
      },
    );
  }

  void _findAllAsset(
    OnFindAllAssetEvent event,
    Emitter<AssetState> emit,
  ) async {
    emit(state.copyWith(status: StatusAsset.loading));

    final failureOrAsset = await _findAllAssetUseCase();

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(status: StatusAsset.failed, message: failure.message),
      ),
      (assets) =>
          emit(state.copyWith(status: StatusAsset.success, assets: assets)),
    );
  }

  void _findDetailAsset(
    OnFindAssetDetailEvent event,
    Emitter<AssetState> emit,
  ) async {
    emit(state.copyWith(status: StatusAsset.loading));

    final failureOrAssetDetail = await _findAssetDetailByIdUseCase(
      event.params,
    );

    return failureOrAssetDetail.fold(
      (failure) => emit(
        state.copyWith(status: StatusAsset.failed, message: failure.message),
      ),
      (assetDetail) => emit(
        state.copyWith(status: StatusAsset.success, assetDetails: assetDetail),
      ),
    );
  }
}
