// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

import '../../domain/entities/asset_category.dart';

class AssetCategoryModel extends Equatable {
  int? id;
  String? name;
  String? init;

  AssetCategoryModel({this.id, this.name, this.init});

  @override
  List<Object?> get props => [id, name, init];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'init': init};
  }

  factory AssetCategoryModel.fromJson(Map<String, dynamic> map) {
    return AssetCategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }

  factory AssetCategoryModel.fromEntity(AssetCategory params) {
    return AssetCategoryModel(
      id: params.id,
      name: params.name,
      init: params.init,
    );
  }

  AssetCategory toEntity() => AssetCategory(id: id, name: name, init: init);
}
