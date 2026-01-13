// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  int? locationId;
  String? purchaseOrder;
  String? location;
  int? modelId;
  String? model;
  int? isConsumable;
  String? category;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return category!;
      case 1:
        return model!;
      case 2:
        return assetCode ?? '';
      case 3:
        return quantity.toString();
      case 4:
        return '';
    }
    return '';
  }

  PreparationDetail({
    this.id,
    this.preparationId,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.locationId,
    this.purchaseOrder,
    this.location,
    this.modelId,
    this.model,
    this.isConsumable,
    this.category,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetId,
      modelId,
      quantity,
      status,
      assetCode,
      locationId,
      purchaseOrder,
      location,
      model,
      isConsumable,
      category,
    ];
  }
}
