// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'inventory_bloc.dart';

enum StatusInventory { initial, loading, failed, loaded, filtered }

// ignore: must_be_immutable
class InventoryState extends Equatable {
  StatusInventory? status;
  List<Inventory>? assets;
  List<Inventory>? filteredAssets;
  String? message;

  InventoryState({
    this.status = StatusInventory.initial,
    this.assets,
    this.filteredAssets,
    this.message,
  });

  InventoryState copyWith({
    StatusInventory? status,
    List<Inventory>? assets,
    List<Inventory>? filteredAssets,
    String? message,
  }) {
    return InventoryState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      filteredAssets: filteredAssets ?? this.filteredAssets,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assets, message, filteredAssets];
}
