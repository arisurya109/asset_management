// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import '../../domain/entities/asset_master.dart';
import 'package:equatable/equatable.dart';

class AssetMasterModel extends Equatable {
  int? id;
  String? name;
  String? type;

  AssetMasterModel({this.id, this.name, this.type});

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{'name': name, 'type': type};
  }

  AssetMaster toEntity() {
    return AssetMaster(id: id, name: name, type: type);
  }

  factory AssetMasterModel.fromEntity(AssetMaster params) {
    return AssetMasterModel(
      id: params.id,
      name: params.name,
      type: params.type,
    );
  }

  factory AssetMasterModel.fromDatabase(Map<String, dynamic> map) {
    return AssetMasterModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  @override
  List<Object?> get props => [id, name, type];
}
