// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/features/assets/domain/entities/asset_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetDetailModel extends Equatable {
  String? movementType;
  String? fromLocation;
  String? toLocation;
  String? movementBy;
  DateTime? movementDate;
  String? referencesNumber;
  String? notes;

  AssetDetailModel({
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

  AssetDetail toEntity() {
    return AssetDetail(
      movementType: movementType,
      fromLocation: fromLocation,
      toLocation: toLocation,
      movementBy: movementBy,
      movementDate: movementDate,
      referencesNumber: referencesNumber,
      notes: notes,
    );
  }

  factory AssetDetailModel.fromJson(Map<String, dynamic> map) {
    return AssetDetailModel(
      movementType: map['movement_type'] != null
          ? map['movement_type'] as String
          : null,
      fromLocation: map['from_location'] != null
          ? map['from_location'] as String
          : null,
      toLocation: map['to_location'] != null
          ? map['to_location'] as String
          : null,
      movementBy: map['movement_by'] != null
          ? map['movement_by'] as String
          : null,
      movementDate: map['movement_date'] != null
          ? DateTime.tryParse(map['movement_date'] as String)
          : null,
      referencesNumber: map['references_number'] != null
          ? map['references_number'] as String
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }
}
