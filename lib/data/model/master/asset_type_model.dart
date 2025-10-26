// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetTypeModel extends Equatable {
  int? id;
  String? name;
  String? init;

  AssetTypeModel({this.id, this.name, this.init});

  @override
  List<Object?> get props => [id, name, init];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'init': init};
  }

  factory AssetTypeModel.fromJson(Map<String, dynamic> map) {
    return AssetTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
    );
  }

  factory AssetTypeModel.fromEntity(AssetType params) {
    return AssetTypeModel(id: params.id, name: params.name, init: params.init);
  }

  AssetType toEntity() {
    return AssetType(id: id, name: name, init: init);
  }
}
