// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:equatable/equatable.dart';

class AssetsModel extends Equatable {
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
  String? locationDetail;
  String? purchaseOrder;
  String? remarks;

  AssetsModel({
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
    this.locationDetail,
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
      locationDetail,
      purchaseOrder,
      remarks,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'is_migration': isMigration,
      'asset_id_old': assetIdOld,
      'serial_number': serialNumber,
      'status': status,
      'conditions': conditions,
      'asset_model_id': assetModelId,
      'color_id': colorId,
      'location_id': locationId,
      'quantity': quantity,
      'uom': uom,
      'purchase_order': purchaseOrder,
      'remarks': remarks,
    };
  }

  factory AssetsModel.fromJson(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'] != null ? map['id'] as int : null,
      serialNumber: map['serial_number'] != null
          ? map['serial_number'] as String
          : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      conditions: map['conditions'] != null
          ? map['conditions'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      uom: map['uom'] != null ? map['uom'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      locationDetail: map['location_detail'] != null
          ? map['location_detail'] as String
          : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
    );
  }

  factory AssetsModel.fromEntity(AssetEntity params) {
    return AssetsModel(
      id: params.id,
      assetCode: params.assetCode,
      assetModelId: params.assetModelId,
      assetIdOld: params.assetIdOld,
      brand: params.brand,
      category: params.category,
      color: params.color,
      colorId: params.colorId,
      conditions: params.conditions,
      isMigration: params.isMigration,
      location: params.location,
      locationDetail: params.locationDetail,
      locationId: params.locationId,
      model: params.model,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      remarks: params.remarks,
      serialNumber: params.serialNumber,
      status: params.status,
      types: params.types,
      uom: params.uom,
    );
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      assetCode: assetCode,
      assetIdOld: assetIdOld,
      assetModelId: assetModelId,
      brand: brand,
      category: category,
      color: color,
      colorId: colorId,
      conditions: conditions,
      isMigration: isMigration,
      locationDetail: locationDetail,
      location: location,
      locationId: locationId,
      model: model,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      remarks: remarks,
      serialNumber: serialNumber,
      status: status,
      types: types,
      uom: uom,
    );
  }
}
