// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

class Movement extends Equatable {
  int? assetId;
  String? type;
  String? destination;
  String? fromLocation;
  String? status;
  String? conditions;
  String? remarks;

  Movement({
    this.type,
    this.assetId,
    this.destination,
    this.fromLocation,
    this.status,
    this.conditions,
    this.remarks,
  });

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
}
