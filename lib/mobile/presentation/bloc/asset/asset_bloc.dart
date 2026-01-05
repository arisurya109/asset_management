import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;

  AssetBloc(this._findAssetByQueryUseCase) : super(AssetState()) {
    on<OnFindAssetByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusAsset.loading));

      final failureOrAssets = await _findAssetByQueryUseCase(
        params: event.params,
      );

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(status: StatusAsset.failure, message: failure.message),
        ),
        (assets) =>
            emit(state.copyWith(status: StatusAsset.success, assets: assets)),
      );
    });

    on<OnClearAll>((event, emit) async {
      emit(state.copyWith(status: StatusAsset.initial, clearAll: true));
    });
  }
}
