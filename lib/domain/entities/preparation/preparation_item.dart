// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationItem extends Equatable {
  int? id;
  int? preparationDetailId;
  int? preparationId;
  int? assetId;
  int? pickedById;
  int? quantity;
  int? locationId;
  String? assetCode;
  int? assetModelId;
  String? assetModel;
  String? assetCategory;
  String? assetBrand;
  String? assetType;
  String? pickedBy;
  String? location;
  String? purchaseOrder;

  PreparationItem({
    this.id,
    this.preparationDetailId,
    this.preparationId,
    this.assetId,
    this.pickedById,
    this.quantity,
    this.locationId,
    this.assetCode,
    this.assetModelId,
    this.assetModel,
    this.assetCategory,
    this.assetBrand,
    this.assetType,
    this.pickedBy,
    this.location,
    this.purchaseOrder,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationDetailId,
      preparationId,
      assetId,
      pickedById,
      quantity,
      locationId,
      assetCode,
      assetModelId,
      assetModel,
      assetCategory,
      assetBrand,
      assetType,
      purchaseOrder,
    ];
  }
}
