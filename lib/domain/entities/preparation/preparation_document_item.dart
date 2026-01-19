// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDocumentItem extends Equatable {
  int? no;
  String? device;
  String? model;
  String? assetCode;
  int? quantity;

  PreparationDocumentItem({
    this.no,
    this.device,
    this.model,
    this.assetCode,
    this.quantity,
  });

  @override
  List<Object?> get props {
    return [no, device, model, assetCode, quantity];
  }
}
