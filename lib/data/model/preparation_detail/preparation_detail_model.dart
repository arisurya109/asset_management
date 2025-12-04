// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDetailModel extends Equatable {
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

  PreparationDetailModel({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_id': preparationId,
      'status': status,
      'notes': notes,
      'asset_model_id': assetModelId,
      'quantity_target': quantityTarget,
      'quantity_picked': quantityPicked,
      'quantity_missing': quantityMissing,
      'exception_status': exceptionStatus,
      'exception_reason': exceptionReason,
    };
  }

  factory PreparationDetailModel.fromJson(Map<String, dynamic> map) {
    return PreparationDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationId: map['preparation_id'] != null
          ? map['preparation_id'] as int
          : null,
      assetModelId: map['asset_model']['id'] != null
          ? map['asset_model']['id'] as int
          : null,
      assetModel: map['asset_model']['name'] != null
          ? map['asset_model']['name'] as String
          : null,
      assetBrand: map['asset_model']['brand'] != null
          ? map['asset_model']['brand'] as String
          : null,
      assetType: map['asset_model']['type'] != null
          ? map['asset_model']['type'] as String
          : null,
      assetCategory: map['asset_model']['category'] != null
          ? map['asset_model']['category'] as String
          : null,
      quantityTarget: map['quantity']['target'] != null
          ? map['quantity']['target'] as int
          : null,
      quantityPicked: map['quantity']['picked'] != null
          ? map['quantity']['picked'] as int
          : null,
      quantityMissing: map['quantity']['missing'] != null
          ? map['quantity']['missing'] as int
          : null,
      exceptionStatus: map['exception']['status'] != null
          ? map['exception']['status'] as String
          : null,
      exceptionReason: map['exception']['reason'] != null
          ? map['exception']['reason'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  factory PreparationDetailModel.fromEntity(PreparationDetail params) {
    return PreparationDetailModel(
      id: params.id,
      assetBrand: params.assetBrand,
      assetCategory: params.assetCategory,
      assetModel: params.assetModel,
      assetModelId: params.assetModelId,
      assetType: params.assetType,
      exceptionReason: params.exceptionReason,
      exceptionStatus: params.exceptionStatus,
      notes: params.notes,
      preparationId: params.preparationId,
      quantityMissing: params.quantityMissing,
      quantityPicked: params.quantityPicked,
      quantityTarget: params.quantityTarget,
      status: params.status,
    );
  }

  PreparationDetail toEntity() {
    return PreparationDetail(
      id: id,
      assetBrand: assetBrand,
      assetCategory: assetCategory,
      assetModel: assetModel,
      assetModelId: assetModelId,
      assetType: assetType,
      exceptionReason: exceptionReason,
      exceptionStatus: exceptionStatus,
      notes: notes,
      preparationId: preparationId,
      quantityMissing: quantityMissing,
      quantityPicked: quantityPicked,
      quantityTarget: quantityTarget,
      status: status,
    );
  }

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
