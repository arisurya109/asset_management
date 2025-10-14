// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class AssetRegistration extends Equatable {
  int? id;
  String? assetCode;
  String? serialNumber;
  String? status;
  int? uom;
  String? conditions;
  String? remarks;
  int? registredBy;
  int? assetModelId;
  String? model;
  String? brand;
  String? type;
  int? colorId;
  String? color;
  String? purchaseOrder;
  int? quantity;
  int? locationDetailId;
  String? locationDetail;
  String? location;
  int? isConsumable;
  String? assetIdOld;

  AssetRegistration({
    this.id,
    this.assetCode,
    this.serialNumber,
    this.uom,
    this.status,
    this.conditions,
    this.remarks,
    this.registredBy,
    this.assetModelId,
    this.model,
    this.brand,
    this.type,
    this.colorId,
    this.color,
    this.purchaseOrder,
    this.quantity,
    this.locationDetailId,
    this.locationDetail,
    this.location,
    this.isConsumable,
    this.assetIdOld,
  });

  @override
  List<Object?> get props {
    return [
      id,
      assetIdOld,
      uom,
      assetCode,
      serialNumber,
      status,
      conditions,
      remarks,
      registredBy,
      assetModelId,
      model,
      brand,
      type,
      colorId,
      color,
      purchaseOrder,
      quantity,
      locationDetailId,
      locationDetail,
      location,
      isConsumable,
    ];
  }
}
