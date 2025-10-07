// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import '../../domain/entities/asset_registration.dart';
import 'package:equatable/equatable.dart';

class AssetRegistrationModel extends Equatable {
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

  AssetRegistrationModel({
    this.id,
    this.assetId,
    this.location,
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

  factory AssetRegistrationModel.fromMap(Map<String, dynamic> map) {
    return AssetRegistrationModel(
      id: map['id'] as int?,
      assetId: map['asset_id'] as String?,
      asset: map['asset'] as String?,
      location: map['location'] as String?,
      brand: map['brand'] as String?,
      status: map['status'] as String?,
      type: map['type'] as String?,
      po: map['po'] as String?,
      description: map['description'] as String?,
      serialNumber: map['serial_number'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      createdBy: map['created_by'] as String?,
    );
  }

  factory AssetRegistrationModel.fromEntity(AssetRegistration params) {
    return AssetRegistrationModel(
      id: params.id,
      assetId: params.assetId,
      asset: params.asset,
      brand: params.brand,
      location: params.location,
      po: params.po,
      status: params.status,
      type: params.type,
      serialNumber: params.serialNumber,
      description: params.description,
      createdAt: params.createdAt,
      createdBy: params.createdBy,
    );
  }

  AssetRegistration toEntity() {
    return AssetRegistration(
      id: id,
      assetId: assetId,
      asset: asset,
      location: location,
      brand: brand,
      status: status,
      type: type,
      po: po,
      serialNumber: serialNumber,
      description: description,
      createdAt: createdAt,
      createdBy: createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'asset': asset,
      'location': location,
      'brand': brand,
      'status': status,
      'type': type,
      'po': po,
      'serial_number': serialNumber,
      'description': description,
      'created_at': createdAt,
      'created_by': createdBy,
    };
  }

  @override
  List<Object?> get props => [
    id,
    assetId,
    location,
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
