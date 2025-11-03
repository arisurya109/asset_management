// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetail extends Equatable {
  int? id;
  int? preparationId;
  int? assetModelId;
  int? quantityTarget;
  int? quantityPicked;
  int? quantityMissing;
  String? exceptionStatus;
  String? exceptionReason;
  String? status;
  String? notes;
  String? assetModel;
  String? assetType;
  String? assetCategory;
  String? assetBrand;

  PreparationDetail({
    this.id,
    this.preparationId,
    this.assetModelId,
    this.quantityTarget,
    this.quantityPicked,
    this.quantityMissing,
    this.exceptionStatus,
    this.exceptionReason,
    this.status,
    this.notes,
    this.assetModel,
    this.assetType,
    this.assetCategory,
    this.assetBrand,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationId,
      assetModelId,
      quantityTarget,
      quantityPicked,
      quantityMissing,
      exceptionStatus,
      exceptionReason,
      status,
      notes,
      assetModel,
      assetType,
      assetCategory,
      assetBrand,
    ];
  }
}
