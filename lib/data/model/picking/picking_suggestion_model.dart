// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/domain/entities/picking/picking_suggestion.dart';
import 'package:equatable/equatable.dart';

class PickingSuggestionModel extends Equatable {
  int? id;
  String? assetCode;
  String? serialNumber;
  int? locationDetailId;
  String? locationDetail;
  int? locationParentId;
  String? locationParent;
  int? quantity;

  PickingSuggestionModel({
    this.id,
    this.assetCode,
    this.serialNumber,
    this.locationDetailId,
    this.locationDetail,
    this.locationParentId,
    this.locationParent,
    this.quantity,
  });

  factory PickingSuggestionModel.fromJson(Map<String, dynamic> map) {
    return PickingSuggestionModel(
      id: map['id'] != null ? map['id'] as int : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      serialNumber: map['serial_number'] != null
          ? map['serial_number'] as String
          : null,
      locationDetailId: map['location']['id'] != null
          ? map['location']['id'] as int
          : null,
      locationDetail: map['location']['name'] != null
          ? map['location']['name'] as String
          : null,
      locationParentId: map['location']['parent']['id'] != null
          ? map['location']['parent']['id'] as int
          : null,
      locationParent: map['location']['parent']['name'] != null
          ? map['location']['parent']['name'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  PickingSuggestion toEntity() {
    return PickingSuggestion(
      id: id,
      assetCode: assetCode,
      serialNumber: serialNumber,
      locationDetailId: locationDetailId,
      locationDetail: locationDetail,
      locationParent: locationParent,
      locationParentId: locationParentId,
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      assetCode,
      serialNumber,
      locationDetailId,
      locationDetail,
      locationParentId,
      locationParent,
      quantity,
    ];
  }
}
