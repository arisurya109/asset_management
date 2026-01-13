// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  int? assetId;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? purchaseOrder;
  String? location;

  PickingDetail({
    this.id,
    this.modelId,
    this.quantity,
    this.isConsumable,
    this.model,
    this.types,
    this.category,
    this.assetId,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.locationId,
    this.purchaseOrder,
    this.location,
  });

  @override
  List<Object?> get props {
    return [
      id,
      modelId,
      quantity,
      isConsumable,
      model,
      types,
      category,
      assetId,
      status,
      assetCode,
      serialNumber,
      locationId,
      location,
      purchaseOrder,
    ];
  }
}
