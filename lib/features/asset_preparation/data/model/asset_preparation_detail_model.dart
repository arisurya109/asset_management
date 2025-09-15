// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, must_be_immutable
import '../../domain/entities/asset_preparation_detail.dart';

import 'package:equatable/equatable.dart';

class AssetPreparationDetailModel extends Equatable {
  int? preparationId;
  String? asset;
  int? quantity;
  String? type;
  String? location;
  String? box;

  AssetPreparationDetailModel({
    this.preparationId,
    this.asset,
    this.quantity,
    this.type,
    this.location,
    this.box,
  });

  @override
  List<Object?> get props {
    return [preparationId, asset, quantity, type, location, box];
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'asset_preparation_id': preparationId,
      'asset': asset,
      'quantity': quantity,
      'type': type,
      'location': location,
      'box': box,
    };
  }

  AssetPreparationDetail toEntity() {
    return AssetPreparationDetail(
      preparationId: preparationId,
      asset: asset,
      location: location,
      box: box,
      type: type,
      quantity: quantity,
    );
  }

  factory AssetPreparationDetailModel.fromEntity(
    AssetPreparationDetail params,
  ) {
    return AssetPreparationDetailModel(
      preparationId: params.preparationId,
      asset: params.asset,
      quantity: params.quantity,
      type: params.type,
      location: params.location,
      box: params.box,
    );
  }

  factory AssetPreparationDetailModel.fromDatabase(Map<String, dynamic> map) {
    return AssetPreparationDetailModel(
      preparationId: map['asset_preparation_id'] != null
          ? map['asset_preparation_id'] as int
          : null,
      asset: map['asset'] != null ? map['asset'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      box: map['box'] != null ? map['box'] as String : null,
    );
  }
}
