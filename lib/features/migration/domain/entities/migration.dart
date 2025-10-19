// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Migration extends Equatable {
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

  Migration({
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
}
