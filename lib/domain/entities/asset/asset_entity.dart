// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class AssetEntity extends Equatable {
  int? id;
  int? isMigration;
  String? assetIdOld;
  String? serialNumber;
  String? assetCode;
  String? status;
  String? conditions;
  int? assetModelId;
  int? colorId;
  int? locationId;
  int? quantity;
  int? uom;
  String? model;
  String? category;
  String? brand;
  String? types;
  String? color;
  String? location;
  String? purchaseOrder;
  String? remarks;

  AssetEntity({
    this.id,
    this.isMigration,
    this.assetIdOld,
    this.serialNumber,
    this.assetCode,
    this.status,
    this.conditions,
    this.assetModelId,
    this.colorId,
    this.locationId,
    this.quantity,
    this.uom,
    this.model,
    this.category,
    this.brand,
    this.types,
    this.color,
    this.location,
    this.purchaseOrder,
    this.remarks,
  });

  @override
  List<Object?> get props {
    return [
      id,
      isMigration,
      assetIdOld,
      serialNumber,
      assetCode,
      status,
      conditions,
      assetModelId,
      colorId,
      locationId,
      quantity,
      uom,
      model,
      category,
      brand,
      types,
      color,
      location,
      purchaseOrder,
      remarks,
    ];
  }
}
