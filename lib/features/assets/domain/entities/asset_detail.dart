// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetDetail extends Equatable {
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetDetail({
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
