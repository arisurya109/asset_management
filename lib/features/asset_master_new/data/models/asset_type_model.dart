// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/features/asset_master_new/domain/entities/asset_type.dart';
import 'package:equatable/equatable.dart';

class AssetTypeModel extends Equatable {
  int? id;
  String? name;

  AssetTypeModel({this.id, this.name});

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory AssetTypeModel.fromJson(Map<String, dynamic> map) {
    return AssetTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  factory AssetTypeModel.fromEntity(AssetType params) {
    return AssetTypeModel(id: params.id, name: params.name);
  }

  AssetType toEntity() {
    return AssetType(id: id, name: name);
  }
}
