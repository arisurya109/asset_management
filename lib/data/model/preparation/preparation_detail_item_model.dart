// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/domain/entities/preparation/preparation_detail_item.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailItemModel extends Equatable {
  int? id;
  int? quantity;
  int? assetId;
  String? assetCode;
  String? serialNumber;
  String? purchaseOrder;
  int? locationId;
  String? location;
  String? status;
  String? conditions;

  PreparationDetailItemModel({
    this.id,
    this.quantity,
    this.assetId,
    this.assetCode,
    this.serialNumber,
    this.purchaseOrder,
    this.locationId,
    this.location,
    this.status,
    this.conditions,
  });

  factory PreparationDetailItemModel.fromJson(Map<String, dynamic> params) {
    return PreparationDetailItemModel(
      id: params['id'] != null ? params['id'] as int : null,
      assetId: params['asset']['id'] != null
          ? params['asset']['id'] as int
          : null,
      purchaseOrder: params['purchase_order'] != null
          ? params['purchase_order'] as String
          : null,
      assetCode: params['asset']['asset_code'] != null
          ? params['asset']['asset_code'] as String
          : null,
      quantity: params['quantity'] != null ? params['quantity'] as int : null,
      locationId: params['location']['id'] != null
          ? params['location']['id'] as int
          : null,
      status: params['asset']['statu'] != null
          ? params['asset']['statu'] as String
          : null,
      serialNumber: params['asset']['serial_number'] != null
          ? params['asset']['serial_number'] as String
          : null,
      conditions: params['asset']['conditions'] != null
          ? params['asset']['conditions'] as String
          : null,
      location: params['location']['name'] != null
          ? params['location']['name'] as String
          : null,
    );
  }

  PreparationDetailItem toEntity() {
    return PreparationDetailItem(
      id: id,
      assetId: assetId,
      assetCode: assetCode,
      conditions: conditions,
      location: location,
      quantity: quantity,
      serialNumber: serialNumber,
      status: status,
      locationId: locationId,
      purchaseOrder: purchaseOrder,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      assetId,
      quantity,
      status,
      assetCode,
      serialNumber,
      conditions,
      purchaseOrder,
      location,
      locationId,
    ];
  }
}
