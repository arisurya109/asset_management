// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'purchase_order_bloc.dart';

enum StatusPurchaseOrder { initial, loading, failed, success }

// ignore: must_be_immutable
class PurchaseOrderState extends Equatable {
  StatusPurchaseOrder? status;
  List<PurchaseOrder>? purchaseOrders;
  List<PurchaseOrderDetail>? assets;
  String? message;

  PurchaseOrderState({
    this.status = StatusPurchaseOrder.initial,
    this.purchaseOrders,
    this.assets,
    this.message,
  });

  @override
  List<Object?> get props => [status, purchaseOrders, assets, message];

  PurchaseOrderState copyWith({
    StatusPurchaseOrder? status,
    List<PurchaseOrder>? purchaseOrders,
    List<PurchaseOrderDetail>? assets,
    String? message,
  }) {
    return PurchaseOrderState(
      status: status ?? this.status,
      purchaseOrders: purchaseOrders ?? this.purchaseOrders,
      assets: assets ?? this.assets,
      message: message ?? this.message,
    );
  }
}
