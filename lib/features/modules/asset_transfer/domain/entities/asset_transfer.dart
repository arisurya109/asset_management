// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class AssetTransfer extends Equatable {
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

  AssetTransfer({
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
}
