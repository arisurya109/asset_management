// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/data/model/preparation/preparation_detail_item_model.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailModel extends Equatable {
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
  List<PreparationDetailItemModel>? allocatedItems;

  PreparationDetailModel({
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

  factory PreparationDetailModel.fromJson(Map<String, dynamic> map) {
    return PreparationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      model: map['asset']['model']['name'] != null
          ? map['asset']['model']['name'] as String
          : null,
      type: map['asset']['type']['name'] != null
          ? map['asset']['type']['name'] as String
          : null,
      brand: map['asset']['brand']['name'] != null
          ? map['asset']['brand']['name'] as String
          : null,
      category: map['asset']['category']['name'] != null
          ? map['asset']['category']['name'] as String
          : null,
      categoryId: map['asset']['category']['id'] != null
          ? map['asset']['category']['id'] as int
          : null,
      modelId: map['asset']['model']['id'] != null
          ? map['asset']['model']['id'] as int
          : null,
      brandId: map['asset']['brand']['id'] != null
          ? map['asset']['brand']['id'] as int
          : null,
      typeId: map['asset']['type']['id'] != null
          ? map['asset']['type']['id'] as int
          : null,
      isConsumable: map['asset']['is_consumable'] != null
          ? map['asset']['is_consumable'] as int
          : null,
      allocatedItems: map['allocated_items'] != null
          ? (map['allocated_items'] as List)
                .map(
                  (e) => PreparationDetailItemModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : null,
    );
  }

  PreparationDetail toEntity() {
    return PreparationDetail(
      id: id,
      category: category,
      isConsumable: isConsumable,
      model: model,
      modelId: modelId,
      preparationId: preparationId,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      status: status,
      brand: brand,
      brandId: brandId,
      categoryId: categoryId,
      type: type,
      typeId: typeId,
      allocatedItems: allocatedItems?.map((e) => e.toEntity()).toList() ?? [],
    );
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
    ];
  }
}
