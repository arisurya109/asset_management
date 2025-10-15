// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:equatable/equatable.dart';

class AssetTransferModel extends Equatable {
  int? id;
  int? assetId;
  String? assetCode;
  String? movementType;
  int? fromLocationId;
  String? fromLocation;
  int? toLocationId;
  String? toLocation;
  int? movementById;
  String? movementBy;
  int? quantity;
  String? notes;

  AssetTransferModel({
    this.id,
    this.assetId,
    this.assetCode,
    this.movementType,
    this.fromLocationId,
    this.fromLocation,
    this.toLocationId,
    this.toLocation,
    this.movementById,
    this.movementBy,
    this.quantity,
    this.notes,
  });

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      assetCode,
      movementType,
      fromLocationId,
      fromLocation,
      toLocationId,
      toLocation,
      movementById,
      movementBy,
      quantity,
      notes,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'asset_id': assetId,
      'asset_code': assetCode,
      'movement_type': movementType,
      'from_location_id': fromLocationId,
      'from_location': fromLocation,
      'to_location_id': toLocationId,
      'to_location': toLocation,
      'movement_by_id': movementById,
      'movement_by': movementBy,
      'quantity': quantity,
      'notes': notes,
    };
  }

  factory AssetTransferModel.fromEntity(AssetTransfer params) {
    return AssetTransferModel(
      id: params.id,
      assetId: params.assetId,
      assetCode: params.assetCode,
      fromLocation: params.fromLocation,
      fromLocationId: params.fromLocationId,
      toLocation: params.toLocation,
      toLocationId: params.toLocationId,
      movementBy: params.movementBy,
      movementById: params.movementById,
      movementType: params.movementType,
      notes: params.notes,
      quantity: params.quantity,
    );
  }
}
