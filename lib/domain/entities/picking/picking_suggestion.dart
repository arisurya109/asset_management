// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class PickingSuggestion extends Equatable {
  int? id;
  String? assetCode;
  String? serialNumber;
  int? locationDetailId;
  String? locationDetail;
  int? locationParentId;
  String? locationParent;
  int? quantity;

  PickingSuggestion({
    this.id,
    this.assetCode,
    this.serialNumber,
    this.locationDetailId,
    this.locationDetail,
    this.locationParentId,
    this.locationParent,
    this.quantity,
  });

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
