import '../../domain/entities/asset_count_detail.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetCountDetailModel extends Equatable {
  int? countId;
  String? assetId;
  String? serialNumber;
  String? assetName;
  String? brandName;
  String? location;
  String? box;
  int? quantity;
  String? status;
  String? condition;

  AssetCountDetailModel({
    this.countId,
    this.assetId,
    this.serialNumber,
    this.assetName,
    this.brandName,
    this.location,
    this.box,
    this.quantity,
    this.status,
    this.condition,
  });

  factory AssetCountDetailModel.fromMap(Map<String, dynamic> params) {
    return AssetCountDetailModel(
      countId: params['count_id'],
      assetId: params['asset_id'],
      assetName: params['asset_name'],
      brandName: params['brand_name'],
      condition: params['condition'],
      location: params['location'],
      quantity: params['quantity'],
      box: params['box'],
      serialNumber: params['serial_number'],
      status: params['status'],
    );
  }

  factory AssetCountDetailModel.fromEntity(AssetCountDetail params) {
    return AssetCountDetailModel(
      countId: params.countId,
      assetId: params.assetId,
      assetName: params.assetName,
      brandName: params.brandName,
      condition: params.condition,
      location: params.location,
      quantity: params.quantity,
      box: params.box,
      serialNumber: params.serialNumber,
      status: params.status,
    );
  }

  AssetCountDetail toEntity() {
    return AssetCountDetail(
      countId: countId,
      assetId: assetId,
      assetName: assetName,
      brandName: brandName,
      condition: condition,
      location: location,
      quantity: quantity,
      box: box,
      serialNumber: serialNumber,
      status: status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count_id': countId,
      'asset_id': assetId,
      'asset_name': assetName,
      'brand_name': brandName,
      'condition': condition,
      'location': location,
      'quantity': quantity,
      'box': box,
      'serial_number': serialNumber,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
    countId,
    assetId,
    serialNumber,
    assetName,
    brandName,
    location,
    quantity,
    box,
    status,
    condition,
  ];
}
