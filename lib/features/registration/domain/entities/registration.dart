// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Registration extends Equatable {
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

  Registration({
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
}
