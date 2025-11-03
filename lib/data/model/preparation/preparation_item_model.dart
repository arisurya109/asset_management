// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationItemModel extends Equatable {
  int? id;
  int? preparationDetailId;
  int? preparationId;
  int? assetId;
  int? pickedById;
  int? quantity;
  int? locationId;
  String? assetCode;
  int? assetModelId;
  String? assetModel;
  String? assetCategory;
  String? assetBrand;
  String? assetType;
  String? pickedBy;
  String? location;

  PreparationItemModel({
    this.id,
    this.preparationDetailId,
    this.preparationId,
    this.assetId,
    this.pickedById,
    this.quantity,
    this.locationId,
    this.assetCode,
    this.assetModelId,
    this.assetModel,
    this.assetCategory,
    this.assetBrand,
    this.assetType,
    this.pickedBy,
    this.location,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'preparation_id': preparationId,
      'preparation_detail_id': preparationDetailId,
      'asset_id': assetId,
      'picked_by_id': pickedById,
      'quantity': quantity,
      'location': locationId,
      'asset_model_id': assetModelId,
    };
  }

  factory PreparationItemModel.fromJson(Map<String, dynamic> map) {
    return PreparationItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationDetailId: map['preparation_detail_id'] != null
          ? map['preparation_detail_id'] as int
          : null,
      preparationId: map['preparation_id'] != null
          ? map['preparation_id'] as int
          : null,
      assetId: map['asset']['id'] != null ? map['asset']['id'] as int : null,
      assetCode: map['asset']['code'] != null
          ? map['asset']['code'] as String
          : null,
      assetModel: map['asset']['model']['name'] != null
          ? map['asset']['model']['name'] as String
          : null,
      assetModelId: map['asset']['model']['id'] != null
          ? map['asset']['model']['id'] as int
          : null,
      assetBrand: map['asset']['brand'] != null
          ? map['asset']['brand'] as String
          : null,
      assetCategory: map['asset']['category'] != null
          ? map['asset']['category'] as String
          : null,
      assetType: map['asset']['type'] != null
          ? map['asset']['type'] as String
          : null,
      pickedById: map['picked']['id'] != null
          ? map['picked']['id'] as int
          : null,
      pickedBy: map['picked']['name'] != null
          ? map['picked']['name'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      locationId: map['location']['id'] != null
          ? map['location']['id'] as int
          : null,
      location: map['location']['name'] != null
          ? map['location']['name'] as String
          : null,
    );
  }

  factory PreparationItemModel.fromEntity(PreparationItem params) {
    return PreparationItemModel(
      id: params.id,
      assetBrand: params.assetBrand,
      assetCategory: params.assetCategory,
      assetCode: params.assetCode,
      assetId: params.assetId,
      assetModel: params.assetModel,
      assetModelId: params.assetModelId,
      assetType: params.assetType,
      location: params.location,
      locationId: params.locationId,
      pickedBy: params.pickedBy,
      pickedById: params.pickedById,
      preparationDetailId: params.preparationDetailId,
      preparationId: params.preparationId,
      quantity: params.quantity,
    );
  }

  PreparationItem toEntity() {
    return PreparationItem(
      id: id,
      assetBrand: assetBrand,
      assetCategory: assetCategory,
      assetCode: assetCode,
      assetId: assetId,
      assetModel: assetModel,
      assetModelId: assetModelId,
      assetType: assetType,
      location: location,
      locationId: locationId,
      pickedBy: pickedBy,
      pickedById: pickedById,
      preparationDetailId: preparationDetailId,
      preparationId: preparationId,
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      preparationDetailId,
      preparationId,
      assetId,
      pickedById,
      quantity,
      locationId,
      assetCode,
      assetModelId,
      assetModel,
      assetCategory,
      assetBrand,
      assetType,
    ];
  }
}
