import 'package:asset_management/features/assets/domain/entities/asset_entity.dart';
import 'package:asset_management/features/assets/domain/usecases/find_all_asset_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final FindAllAssetUseCase _findAllAssetUseCase;

  AssetsBloc(this._findAllAssetUseCase) : super(AssetsState()) {
    on<OnGetAllAssets>((event, emit) async {
      emit(state.copyWith(status: StatusAssets.loading));

      final failureOrAsset = await _findAllAssetUseCase();

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(status: StatusAssets.failed, message: failure.message),
        ),
        (assets) =>
            emit(state.copyWith(status: StatusAssets.success, assets: assets)),
      );
    });

    on<OnSearchAssets>((event, emit) async {
      final query = event.params.trim().toLowerCase();

      if (query.isEmpty) {
        emit(
          state.copyWith(
            status: StatusAssets.success,
            assets: state.assets,
            filteredAssets: null,
          ),
        );
      }

      final filtered = state.assets?.where((asset) {
        final assetCode = asset.assetCode ?? '';
        final serialNumber = asset.serialNumber ?? '';
        final location = asset.location ?? '';
        final status = asset.status ?? '';
        final conditions = asset.conditions ?? '';

        return assetCode.toLowerCase().contains(query) ||
            serialNumber.toLowerCase().contains(query) ||
            location.toLowerCase().contains(query) ||
            status.toLowerCase().contains(query) ||
            conditions.toLowerCase().contains(query);
      }).toList();

      emit(
        state.copyWith(filteredAssets: filtered, status: StatusAssets.filtered),
      );
    });
  }
}
