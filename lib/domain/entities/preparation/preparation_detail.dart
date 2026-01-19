// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/preparation/preparation_detail_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? quantity;
  String? status;
  String? purchaseOrder;
  int? modelId;
  String? model;
  int? isConsumable;
  int? categoryId;
  String? category;
  String? brand;
  int? brandId;
  String? type;
  int? typeId;
  List<PreparationDetailItem>? allocatedItems;

  PreparationDetail({
    this.id,
    this.preparationId,
    this.quantity,
    this.status,
    this.purchaseOrder,
    this.modelId,
    this.model,
    this.isConsumable,
    this.categoryId,
    this.category,
    this.brand,
    this.brandId,
    this.type,
    this.typeId,
    this.allocatedItems,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return category!;
      case 1:
        return model!;
      case 2:
        return type ?? '';
      case 3:
        return quantity.toString();
      case 4:
        return '';
    }
    return '';
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      modelId,
      quantity,
      status,
      purchaseOrder,
      model,
      modelId,
      isConsumable,
      category,
      categoryId,
      brand,
      brandId,
      category,
      categoryId,
      allocatedItems,
    ];
  }
}
