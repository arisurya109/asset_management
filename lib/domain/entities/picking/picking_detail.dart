// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/picking/picking_suggestion.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetail extends Equatable {
  int? id;
  int? modelId;
  String? model;
  int? typeId;
  String? type;
  int? categoryId;
  String? category;
  int? brandId;
  String? brand;
  int? isConsumable;
  String? status;
  String? purchaseOrder;
  int? quantity;
  List<PickingSuggestion>? suggestion;

  PickingDetail({
    this.id,
    this.modelId,
    this.model,
    this.typeId,
    this.type,
    this.categoryId,
    this.category,
    this.brandId,
    this.brand,
    this.isConsumable,
    this.status,
    this.purchaseOrder,
    this.quantity,
    this.suggestion,
  });

  @override
  List<Object?> get props {
    return [
      id,
      modelId,
      model,
      typeId,
      type,
      categoryId,
      category,
      brandId,
      brand,
      isConsumable,
      status,
      purchaseOrder,
      quantity,
      suggestion,
    ];
  }
}
