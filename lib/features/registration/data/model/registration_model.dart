// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/features/registration/domain/entities/registration.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class RegistrationModel extends Equatable {
  String? serialNumber;
  String? status;
  int? uom;
  String? conditions;
  String? remarks;
  int? assetModelId;
  int? colorId;
  String? purchaseOrder;
  int? quantity;
  int? locationId;
  int? isConsumable;

  RegistrationModel({
    this.serialNumber,
    this.status,
    this.uom,
    this.conditions,
    this.remarks,
    this.assetModelId,
    this.colorId,
    this.purchaseOrder,
    this.quantity,
    this.locationId,
    this.isConsumable,
  });

  @override
  List<Object?> get props {
    return [
      serialNumber,
      status,
      uom,
      conditions,
      remarks,
      assetModelId,
      colorId,
      purchaseOrder,
      quantity,
      locationId,
      isConsumable,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'serial_number': serialNumber,
      'status': status,
      'uom': uom,
      'conditions': conditions,
      'remarks': remarks,
      'asset_model_id': assetModelId,
      'color_id': colorId,
      'purchase_order': purchaseOrder,
      'quantity': quantity,
      'location_id': locationId,
      'is_consumable': isConsumable,
    };
  }

  factory RegistrationModel.fromEntity(Registration params) {
    return RegistrationModel(
      assetModelId: params.assetModelId,
      colorId: params.colorId,
      conditions: params.conditions,
      isConsumable: params.isConsumable,
      locationId: params.locationId,
      purchaseOrder: params.purchaseOrder,
      quantity: params.quantity,
      remarks: params.remarks,
      serialNumber: params.serialNumber,
      status: params.status,
      uom: params.uom,
    );
  }
}
