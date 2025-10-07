// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:equatable/equatable.dart';

class AssetRegistration extends Equatable {
  int? id;
  String? location;
  String? assetId;
  String? asset;
  String? brand;
  String? type;
  String? status;
  String? description;
  String? po;
  String? serialNumber;
  DateTime? createdAt;
  String? createdBy;

  AssetRegistration({
    this.id,
    this.location,
    this.assetId,
    this.asset,
    this.brand,
    this.type,
    this.status,
    this.description,
    this.po,
    this.serialNumber,
    this.createdAt,
    this.createdBy,
  });

  @override
  List<Object?> get props => [
    id,
    location,
    assetId,
    asset,
    brand,
    type,
    status,
    description,
    po,
    serialNumber,
    createdAt,
    createdBy,
  ];
}
