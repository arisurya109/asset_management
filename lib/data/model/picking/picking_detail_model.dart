// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/data/model/picking/picking_suggestion_model.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailModel extends Equatable {
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
  List<PickingSuggestionModel>? suggestion;

  PickingDetailModel({
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

  factory PickingDetailModel.fromJson(Map<String, dynamic> map) {
    return PickingDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      modelId: map['asset']['model']['id'] != null
          ? map['asset']['model']['id'] as int
          : null,
      model: map['asset']['model']['name'] != null
          ? map['asset']['model']['name'] as String
          : null,
      typeId: map['asset']['type']['id'] != null
          ? map['asset']['type']['id'] as int
          : null,
      type: map['asset']['type']['name'] != null
          ? map['asset']['type']['name'] as String
          : null,
      categoryId: map['asset']['category']['id'] != null
          ? map['asset']['category']['id'] as int
          : null,
      category: map['asset']['category']['name'] != null
          ? map['asset']['category']['name'] as String
          : null,
      brandId: map['asset']['brand']['id'] != null
          ? map['asset']['brand']['id'] as int
          : null,
      brand: map['asset']['brand']['name'] != null
          ? map['asset']['brand']['name'] as String
          : null,
      isConsumable: map['is_consumable'] != null
          ? map['is_consumable'] as int
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      suggestion: map['suggestion'] != null
          ? (map['suggestion'] as List?)
                    ?.map(
                      (e) => PickingSuggestionModel.fromJson(
                        e as Map<String, dynamic>,
                      ),
                    )
                    .toList() ??
                []
          : null,
    );
  }

  PickingDetail toEntity() {
    return PickingDetail(
      id: id,
      model: model,
      modelId: modelId,
      type: type,
      typeId: typeId,
      category: category,
      categoryId: categoryId,
      brand: brand,
      brandId: brandId,
      isConsumable: isConsumable,
      status: status,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      suggestion: suggestion?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

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
