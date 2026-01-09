// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class PreparationDetailItem extends Equatable {
  int? id;
  int? preparationDetailId;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  String? serialNumber;
  String? conditions;
  String? location;

  PreparationDetailItem({
    this.id,
    this.preparationDetailId,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.conditions,
    this.location,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationDetailId,
      assetId,
      quantity,
      status,
      assetCode,
      serialNumber,
      conditions,
      location,
    ];
  }
}
