// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/core.dart';
import 'package:asset_management/services/printer_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/find_all_inventory_use_case.dart';
import '../../domain/entities/inventory.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final FindAllInventoryUseCase _useCase;
  final PrinterServices _printerServices;

  InventoryBloc(this._useCase, this._printerServices)
    : super(InventoryState()) {
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
            asset.location!.toLowerCase().contains(query) ||
            asset.serialNumber!.toLowerCase().contains(query) ||
            asset.status!.toLowerCase().contains(query) ||
            asset.conditions!.toLowerCase().contains(query) ||
            asset.model!.toLowerCase().contains(query);
      }).toList();

      emit(
        state.copyWith(
          filteredAssets: filtered,
          status: StatusInventory.filtered,
        ),
      );
    });

    on<OnReprintAsset>((event, emit) async {
      final printer = await _printerServices.getConnectionPrinter();

      final command = ConfigLabel.AssetIdNormal(event.assetCode);
      final command2 = ConfigLabel.AssetIdLarge(event.assetCode);

      printer.write(command);
      printer.write(command2);

      await printer.flush();
      await printer.close();
    });
  }
}
