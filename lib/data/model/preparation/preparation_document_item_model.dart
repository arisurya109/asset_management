// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/preparation/preparation_document_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDocumentItemModel extends Equatable {
  int? no;
  String? device;
  String? model;
  String? assetCode;
  int? quantity;

  PreparationDocumentItemModel({
    this.no,
    this.device,
    this.model,
    this.assetCode,
    this.quantity,
  });

  factory PreparationDocumentItemModel.fromJson(Map<String, dynamic> map) {
    return PreparationDocumentItemModel(
      no: map['no'] != null ? map['no'] as int : null,
      device: map['device'] != null ? map['device'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  PreparationDocumentItem toEntity() {
    return PreparationDocumentItem(
      no: no,
      assetCode: assetCode,
      device: device,
      model: model,
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props {
    return [no, device, model, assetCode, quantity];
  }
}
