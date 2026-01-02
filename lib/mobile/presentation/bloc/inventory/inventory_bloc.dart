import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/inventory/inventory.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/inventory/find_inventory_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final FindInventoryUseCase _findInventoryUseCase;
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;

  InventoryBloc(this._findInventoryUseCase, this._findAssetByQueryUseCase)
    : super(InventoryState()) {
    on<OnFindInventory>((event, emit) async {
      emit(state.copyWith(status: StatusInventory.loading));

      final failureOrInventory = await _findInventoryUseCase(event.params);

      return failureOrInventory.fold(
        (_) async {
          final failureOrAsset = await _findAssetByQueryUseCase(
            params: event.params,
          );

          return failureOrAsset.fold(
            (_) => emit(
              state.copyWith(
                status: StatusInventory.failure,
                message: 'Not record found',
              ),
            ),
            (assets) => emit(
              state.copyWith(
                status: StatusInventory.loaded,
                inventory: null,
                assets: assets,
              ),
            ),
          );
        },
        (inventory) async {
          final failureOrAsset = await _findAssetByQueryUseCase(
            params: event.params,
          );

          return failureOrAsset.fold(
            (_) => emit(
              state.copyWith(
                status: StatusInventory.loaded,
                inventory: inventory,
              ),
            ),
            (assets) => emit(
              state.copyWith(
                status: StatusInventory.loaded,
                inventory: inventory,
                assets: assets,
              ),
            ),
          );
        },
      );
    });
    on<OnClearAll>((event, emit) async {
      emit(state.copyWith(status: StatusInventory.initial, clearAll: true));
    });
  }
}
