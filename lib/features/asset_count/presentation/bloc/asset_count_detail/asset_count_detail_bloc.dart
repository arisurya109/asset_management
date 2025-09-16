// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../../../core/utils/enum.dart';
import '../../../domain/entities/asset_count_detail.dart';
import 'package:bloc/bloc.dart';
part 'asset_count_detail_event.dart';
part 'asset_count_detail_state.dart';

class AssetCountDetailBloc
    extends Bloc<AssetCountDetailEvent, AssetCountDetailState> {
  final FindAllAssetCountDetailByIdCountUseCase _get;
  final InsertAssetCountDetailUseCase _create;
  final DeleteAssetCountDetailUseCase _delete;
  AssetCountDetailBloc(this._get, this._create, this._delete)
    : super(AssetCountDetailState()) {
    on<OnGetAllAssetCountDetailById>(_getAssets);
    on<OnCreateAssetCountDetail>(_createAsset);
    on<OnDeleteAssetCountDetail>(_deleteAsset);
  }

  void _deleteAsset(
    OnDeleteAssetCountDetail event,
    Emitter<AssetCountDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCountDetail.loading));

    final failureOrAsset = await _delete(event.countId, event.params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCountDetail.failed,
          message: failure.message,
        ),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusAssetCountDetail.deleted,
          assets: state.assets
            ?..removeWhere((element) => element.assetId == event.params),
        ),
      ),
    );
  }

  void _createAsset(
    OnCreateAssetCountDetail event,
    Emitter<AssetCountDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCountDetail.loading));

    final failureOrAsset = await _create(event.params);

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCountDetail.failed,
          message: failure.message,
        ),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusAssetCountDetail.created,
          assets: state.assets?..add(asset),
          message: 'Successfully Add ${asset.assetId} To ${asset.location}',
        ),
      ),
    );
  }

  void _getAssets(
    OnGetAllAssetCountDetailById event,
    Emitter<AssetCountDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusAssetCountDetail.loading));

    final failureOrAssets = await _get(event.params);

    return failureOrAssets.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusAssetCountDetail.failed,
          message: failure.message,
        ),
      ),
      (assets) => emit(
        state.copyWith(status: StatusAssetCountDetail.loaded, assets: assets),
      ),
    );
  }
}
