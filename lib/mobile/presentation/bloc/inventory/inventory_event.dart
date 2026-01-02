part of 'inventory_bloc.dart';

class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class OnFindInventory extends InventoryEvent {
  final String params;

  const OnFindInventory(this.params);
}

class OnClearAll extends InventoryEvent {}
