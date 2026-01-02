// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'inventory_bloc.dart';

enum StatusInventory { initial, loading, failure, loaded }

class InventoryState extends Equatable {
  StatusInventory? status;
  Inventory? inventory;
  List<AssetEntity>? assets;
  String? message;

  InventoryState({
    this.status = StatusInventory.initial,
    this.inventory,
    this.assets,
    this.message,
  });

  @override
  List<Object?> get props => [status, inventory, assets, message];

  InventoryState copyWith({
    StatusInventory? status,
    bool clearAll = false,
    Inventory? inventory,
    List<AssetEntity>? assets,
    String? message,
  }) {
    return InventoryState(
      status: status ?? this.status,
      inventory: clearAll ? null : (inventory ?? this.inventory),
      assets: clearAll ? null : (assets ?? this.assets),
      message: message ?? this.message,
    );
  }
}
