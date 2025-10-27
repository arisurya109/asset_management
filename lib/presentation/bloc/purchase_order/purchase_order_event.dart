part of 'purchase_order_bloc.dart';

class PurchaseOrderEvent extends Equatable {
  const PurchaseOrderEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePurchaseOrderEvent extends PurchaseOrderEvent {
  final PurchaseOrder params;

  const OnCreatePurchaseOrderEvent(this.params);
}

class OnFindAllPurchaseOrderEvent extends PurchaseOrderEvent {}

class OnFindAllAssetPurchaseOrderEvent extends PurchaseOrderEvent {
  final int params;

  const OnFindAllAssetPurchaseOrderEvent(this.params);
}
