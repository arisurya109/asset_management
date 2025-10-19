// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

import '../../domain/entities/asset_model.dart';

class AssetModelModel extends Equatable {
  int? id;
  String? name;
  int? hasSerial;
  int? isConsumable;
  int? unit;
  int? typeId;
  int? categoryId;
  int? brandId;
  String? typeName;
  String? categoryName;
  String? brandName;

  AssetModelModel({
    this.id,
    this.name,
    this.hasSerial,
    this.isConsumable,
    this.unit,
    this.typeId,
    this.categoryId,
    this.brandId,
    this.typeName,
    this.categoryName,
    this.brandName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      hasSerial,
      isConsumable,
      unit,
      typeId,
      categoryId,
      brandId,
      typeName,
      categoryName,
      brandName,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'has_serial': hasSerial,
      'is_consumable': isConsumable,
      'unit': unit,
      'type_id': typeId,
      'category_id': categoryId,
      'brand_id': brandId,
      'type_name': typeName,
      'category_name': categoryName,
      'brand_name': brandName,
    };
  }

  factory AssetModelModel.fromJson(Map<String, dynamic> map) {
    return AssetModelModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      hasSerial: map['has_serial'] != null ? map['has_serial'] as int : null,
      isConsumable: map['is_consumable'] != null
          ? map['is_consumable'] as int
          : null,
      unit: map['unit'] != null ? map['unit'] as int : null,
      typeId: map['type']['id'] != null ? map['type']['id'] as int : null,
      categoryId: map['category']['id'] != null
          ? map['category']['id'] as int
          : null,
      brandId: map['brand']['id'] != null ? map['brand']['id'] as int : null,
      typeName: map['type']['name'] != null
          ? map['type']['name'] as String
          : null,
      categoryName: map['category']['name'] != null
          ? map['category']['name'] as String
          : null,
      brandName: map['brand']['name'] != null
          ? map['brand']['name'] as String
          : null,
    );
  }

  factory AssetModelModel.fromEntity(AssetModel params) {
    return AssetModelModel(
      id: params.id,
      name: params.name,
      hasSerial: params.hasSerial,
      isConsumable: params.isConsumable,
      unit: params.unit,
      typeId: params.typeId,
      typeName: params.typeName,
      brandId: params.brandId,
      brandName: params.brandName,
      categoryId: params.categoryId,
      categoryName: params.categoryName,
    );
  }

  AssetModel toEntity() {
    return AssetModel(
      id: id,
      name: name,
      hasSerial: hasSerial,
      isConsumable: isConsumable,
      unit: unit,
      typeId: typeId,
      typeName: typeName,
      brandId: brandId,
      brandName: brandName,
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }
}
