// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/picking/picking_detail_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetail extends Equatable {
  int? id;
  int? modelId;
  int? quantity;
  int? isConsumable;
  String? model;
  String? types;
  String? category;
  List<PickingDetailItem>? allocatedItems;

  PickingDetail({
    this.id,
    this.modelId,
    this.quantity,
    this.isConsumable,
    this.model,
    this.types,
    this.category,
    this.allocatedItems,
  });

  @override
  List<Object?> get props {
    return [id, modelId, quantity, isConsumable, model, types, category];
  }
}
