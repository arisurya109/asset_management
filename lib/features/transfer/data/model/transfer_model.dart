// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/features/transfer/domain/entities/transfer.dart';
import 'package:equatable/equatable.dart';

class TransferModel extends Equatable {
  int? assetId;
  String? movementType;
  int? fromLocationId;
  int? toLocationId;
  int? quantity;
  String? notes;

  TransferModel({
    this.assetId,
    this.movementType,
    this.fromLocationId,
    this.toLocationId,
    this.quantity,
    this.notes,
  });

  @override
  List<Object?> get props {
    return [
      assetId,
      movementType,
      fromLocationId,
      toLocationId,
      quantity,
      notes,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'asset_id': assetId,
      'movement_type': movementType,
      'from_location_id': fromLocationId,
      'to_location_id': toLocationId,
      'quantity': quantity,
      'notes': notes,
    };
  }

  factory TransferModel.fromEntity(Transfer params) {
    return TransferModel(
      assetId: params.assetId,
      movementType: params.movementType,
      fromLocationId: params.fromLocationId,
      toLocationId: params.toLocationId,
      quantity: params.quantity,
      notes: params.notes,
    );
  }
}
