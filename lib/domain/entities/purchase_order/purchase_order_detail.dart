import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PurchaseOrderDetail extends Equatable {
  int? id;
  int? purchaseOrderId;
  int? modelId;
  int? quantity;
  String? poNumber;
  String? types;
  String? brand;
  String? category;
  String? model;

  PurchaseOrderDetail({
    this.id,
    this.purchaseOrderId,
    this.modelId,
    this.quantity,
    this.poNumber,
    this.types,
    this.brand,
    this.category,
    this.model,
  });

  @override
  List<Object?> get props {
    return [
      id,
      purchaseOrderId,
      modelId,
      quantity,
      poNumber,
      types,
      brand,
      category,
      model,
    ];
  }

  PurchaseOrderDetail copyWith({
    int? id,
    int? purchaseOrderId,
    int? modelId,
    int? quantity,
    String? poNumber,
    String? types,
    String? brand,
    String? category,
    String? model,
  }) {
    return PurchaseOrderDetail(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      modelId: modelId ?? this.modelId,
      quantity: quantity ?? this.quantity,
      poNumber: poNumber ?? this.poNumber,
      types: types ?? this.types,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      model: model ?? this.model,
    );
  }
}
