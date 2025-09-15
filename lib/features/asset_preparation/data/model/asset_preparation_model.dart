// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, depend_on_referenced_packages
import '../../domain/entities/asset_preparation.dart';

import 'package:equatable/equatable.dart';

class AssetPreparationModel extends Equatable {
  int? id;
  String? storeName;
  int? storeCode;
  String? storeInitial;
  String? status;
  int? totalBox;
  String? type;
  String? createdAt;
  String? updatedAt;

  AssetPreparationModel({
    this.id,
    this.storeName,
    this.storeCode,
    this.storeInitial,
    this.status,
    this.totalBox,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      storeName,
      storeCode,
      storeInitial,
      status,
      totalBox,
      type,
      createdAt,
      updatedAt,
    ];
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'store_name': storeName,
      'store_code': storeCode,
      'store_initial': storeInitial,
      'status': status,
      'type': type,
      'created_at': createdAt,
    };
  }

  AssetPreparation toEntity() {
    return AssetPreparation(
      id: id,
      storeName: storeName,
      storeCode: storeCode,
      storeInitial: storeInitial,
      status: status,
      totalBox: totalBox,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AssetPreparationModel.fromEntity(AssetPreparation params) {
    return AssetPreparationModel(
      id: params.id,
      storeName: params.storeName,
      storeCode: params.storeCode,
      storeInitial: params.storeInitial,
      status: params.status,
      totalBox: params.totalBox,
      type: params.type,
      createdAt: params.createdAt,
      updatedAt: params.updatedAt,
    );
  }

  factory AssetPreparationModel.fromDatabase(Map<String, dynamic> map) {
    return AssetPreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      storeName: map['store_name'] != null ? map['store_name'] as String : null,
      storeCode: map['store_code'] != null ? map['store_code'] as int : null,
      storeInitial: map['store_initial'] != null
          ? map['store_initial'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }
}
