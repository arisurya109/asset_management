// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetDetail extends Equatable {
  int? id;
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetDetail({
    this.id,
    this.movementType,
    this.fromLocation,
    this.toLocation,
    this.movementBy,
    this.movementDate,
    this.referencesNumber,
    this.notes,
  });

  @override
  List<Object?> get props {
    return [
      id,
      movementType,
      fromLocation,
      toLocation,
      movementBy,
      movementDate,
      referencesNumber,
      notes,
    ];
  }
}
