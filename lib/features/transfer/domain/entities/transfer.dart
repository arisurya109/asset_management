// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  int? assetId;
  String? movementType;
  int? fromLocationId;
  int? toLocationId;
  int? quantity;
  String? notes;

  Transfer({
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
}
