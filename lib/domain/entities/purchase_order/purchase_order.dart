// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';

// ignore: must_be_immutable
class PurchaseOrder extends Equatable {
  int? id;
  String? purchaseOrderNumber;
  int? vendorId;
  int? createdById;
  String? remarks;
  String? status;
  String? createdBy;
  String? vendor;
  List<PurchaseOrderDetail>? items;

  PurchaseOrder({
    this.id,
    this.purchaseOrderNumber,
    this.vendorId,
    this.createdById,
    this.remarks,
    this.status,
    this.createdBy,
    this.vendor,
    this.items,
  });

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderNumber,
      vendorId,
      createdById,
      createdBy,
      remarks,
      status,
      vendor,
      items,
    ];
  }

  PurchaseOrder copyWith({
    int? id,
    String? purchaseOrderNumber,
    int? vendorId,
    int? createdById,
    String? remarks,
    String? status,
    String? createdBy,
    String? vendor,
    List<PurchaseOrderDetail>? items,
  }) {
    return PurchaseOrder(
      id: id ?? this.id,
      purchaseOrderNumber: purchaseOrderNumber ?? this.purchaseOrderNumber,
      vendorId: vendorId ?? this.vendorId,
      createdById: createdById ?? this.createdById,
      remarks: remarks ?? this.remarks,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      vendor: vendor ?? this.vendor,
      items: items ?? this.items,
    );
  }
}
