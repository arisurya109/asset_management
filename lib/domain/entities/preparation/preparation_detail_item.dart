// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class PreparationDetailItem extends Equatable {
  int? id;
  int? quantity;
  int? assetId;
  String? assetCode;
  String? serialNumber;
  String? purchaseOrder;
  int? locationId;
  String? location;
  String? status;
  String? conditions;

  PreparationDetailItem({
    this.id,
    this.quantity,
    this.assetId,
    this.assetCode,
    this.serialNumber,
    this.purchaseOrder,
    this.locationId,
    this.location,
    this.status,
    this.conditions,
  });

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      quantity,
      status,
      assetCode,
      serialNumber,
      conditions,
      purchaseOrder,
      location,
      locationId,
    ];
  }
}
