// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:asset_management/domain/entities/preparation/preparation_detail_item.dart';
import 'package:equatable/equatable.dart';

class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? modelId;
  int? isConsumable;
  String? purchaseOrder;
  int? quantity;
  String? model;
  String? type;
  String? category;
  String? brand;
  List<PreparationDetailItem>? items;

  PreparationDetail({
    this.id,
    this.preparationId,
    this.modelId,
    this.isConsumable,
    this.purchaseOrder,
    this.quantity,
    this.model,
    this.type,
    this.category,
    this.brand,
    this.items,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      modelId,
      purchaseOrder,
      quantity,
      model,
      type,
      category,
      brand,
      items,
    ];
  }
}
