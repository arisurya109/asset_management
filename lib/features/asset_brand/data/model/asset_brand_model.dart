// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

import '../../domain/entities/asset_brand.dart';

class AssetBrandModel extends Equatable {
  int? id;
  String? name;
  String? init;

  AssetBrandModel({this.id, this.name, this.init});

  @override
  List<Object?> get props => [id, name, init];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'init': init};
  }

  factory AssetBrandModel.fromJson(Map<String, dynamic> map) {
    return AssetBrandModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }

  factory AssetBrandModel.fromEntity(AssetBrand params) {
    return AssetBrandModel(id: params.id, name: params.name, init: params.init);
  }

  AssetBrand toEntity() => AssetBrand(id: id, name: name, init: init);
}
