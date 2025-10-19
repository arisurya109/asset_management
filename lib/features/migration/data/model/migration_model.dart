// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/features/migration/domain/entities/migration.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MigrationModel extends Equatable {
  String? assetIdOld;
  String? status;
  int? uom;
  String? conditions;
  String? remarks;
  int? assetModelId;
  int? colorId;
  int? quantity;
  int? locationId;
  int? isConsumable;

  MigrationModel({
    this.assetIdOld,
    this.status,
    this.uom,
    this.conditions,
    this.remarks,
    this.assetModelId,
    this.colorId,
    this.quantity,
    this.locationId,
    this.isConsumable,
  });

  @override
  List<Object?> get props {
    return [
      assetIdOld,
      status,
      uom,
      conditions,
      remarks,
      assetModelId,
      colorId,
      quantity,
      locationId,
      isConsumable,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'asset_id_old': assetIdOld,
      'status': status,
      'uom': uom,
      'conditions': conditions,
      'remarks': remarks,
      'asset_model_id': assetModelId,
      'color_id': colorId,
      'quantity': quantity,
      'location_id': locationId,
      'is_consumable': isConsumable,
    };
  }

  factory MigrationModel.fromEntity(Migration params) {
    return MigrationModel(
      assetIdOld: params.assetIdOld,
      status: params.status,
      uom: params.uom,
      conditions: params.conditions,
      remarks: params.remarks,
      assetModelId: params.assetModelId,
      colorId: params.colorId,
      quantity: params.quantity,
      locationId: params.locationId,
      isConsumable: params.isConsumable,
    );
  }
}
