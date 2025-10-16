// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/find_all_inventory_use_case.dart';
import '../../domain/entities/inventory.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final FindAllInventoryUseCase _useCase;
  InventoryBloc(this._useCase) : super(InventoryState()) {
    on<OnGetAllInventory>((event, emit) async {
      emit(state.copyWith(status: StatusInventory.loading));

      final failureOrDatas = await _useCase();

      return failureOrDatas.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusInventory.failed,
            message: failure.message,
          ),
        ),
        (datas) =>
            emit(state.copyWith(status: StatusInventory.loaded, assets: datas)),
      );
    });

    on<OnSearchInventory>((event, emit) async {
      final query = event.params.trim().toLowerCase();

      if (query.isEmpty) {
        emit(
          state.copyWith(
            status: StatusInventory.loaded,
            assets: state.assets,
            filteredAssets: null,
          ),
        );
      }

      final filtered = state.assets?.where((asset) {
        return asset.assetCode!.toLowerCase().contains(query) ||
            asset.location!.toLowerCase().contains(query);
      }).toList();

      emit(
        state.copyWith(
          filteredAssets: filtered,
          status: StatusInventory.filtered,
        ),
      );
    });
  }
}
