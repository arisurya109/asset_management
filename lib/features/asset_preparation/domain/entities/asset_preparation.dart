// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class AssetPreparation extends Equatable {
  int? id;
  String? storeName;
  int? storeCode;
  String? storeInitial;
  String? status;
  int? totalBox;
  String? type;
  String? createdAt;
  String? updatedAt;

  AssetPreparation({
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
}
