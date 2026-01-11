// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailItem extends Equatable {
  int? id;
  int? assetId;
  int? quantity;
  String? status;
  String? assetCode;
  String? serialNumber;
  int? locationId;
  String? location;

  PickingDetailItem({
    this.id,
    this.assetId,
    this.quantity,
    this.status,
    this.assetCode,
    this.serialNumber,
    this.locationId,
    this.location,
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
      locationId,
      location,
    ];
  }
}
