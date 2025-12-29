import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/usecases/asset/find_all_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_desktop_event.dart';
part 'asset_desktop_state.dart';

class AssetDesktopBloc extends Bloc<AssetDesktopEvent, AssetDesktopState> {
  final FindAllAssetUseCase _findAllAssetUseCase;
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;

  AssetDesktopBloc(this._findAllAssetUseCase, this._findAssetByQueryUseCase)
    : super(AssetDesktopState()) {
    on<OnFindAllAssets>((event, emit) async {
      emit(state.copyWith(status: StatusAssetDesktop.loading));

      final failureOrAssets = await _findAllAssetUseCase();

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetDesktop.failure,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(status: StatusAssetDesktop.loaded, assets: assets),
        ),
      );
    });
    on<OnFindAssetsByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusAssetDesktop.loading));

      final failureOrAssets = await _findAssetByQueryUseCase(
        params: event.params,
      );

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetDesktop.failure,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(status: StatusAssetDesktop.loaded, assets: assets),
        ),
      );
    });
  }
}
