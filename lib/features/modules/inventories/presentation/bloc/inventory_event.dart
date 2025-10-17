part of 'inventory_bloc.dart';

class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllInventory extends InventoryEvent {}

class OnSearchInventory extends InventoryEvent {
  final String params;

  const OnSearchInventory(this.params);
}

class OnReprintAsset extends InventoryEvent {
  final String assetCode;

  const OnReprintAsset(this.assetCode);
}
