// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class AssetModel extends Equatable {
  int? id;
  String? name;
  String? code;
  int? hasSerial;
  int? isConsumable;
  int? unit;
  int? typeId;
  int? categoryId;
  int? brandId;
  String? typeName;
  String? categoryName;
  String? brandName;

  AssetModel({
    this.id,
    this.name,
    this.code,
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
      code,
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
}
