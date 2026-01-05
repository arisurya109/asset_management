// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/movement/movement.dart';

class MovementModel extends Equatable {
  int? assetId;
  String? type;
  String? fromLocation;
  String? destination;
  String? status;
  String? conditions;
  String? remarks;

  MovementModel({
    this.type,
    this.assetId,
    this.fromLocation,
    this.destination,
    this.status,
    this.conditions,
    this.remarks,
  });

  factory MovementModel.fromEntity(Movement params) {
    return MovementModel(
      type: params.type,
      assetId: params.assetId,
      fromLocation: params.fromLocation,
      destination: params.destination,
      status: params.status,
      conditions: params.conditions,
      remarks: params.remarks,
    );
  }

  @override
  List<Object?> get props => [
    type,
    assetId,
    fromLocation,
    destination,
    status,
    conditions,
    remarks,
  ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'from_location': fromLocation,
      'destination': destination,
      'status': status,
      'conditions': conditions,
      'remarks': remarks,
    };
  }
}
