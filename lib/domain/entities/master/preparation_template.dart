// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/master/preparation_template_item.dart';

// ignore: must_be_immutable
class PreparationTemplate extends Equatable {
  int? id;
  String? templateCode;
  String? name;
  String? description;
  int? isActive;
  int? createdById;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  List<PreparationTemplateItem>? items;

  PreparationTemplate({
    this.id,
    this.templateCode,
    this.name,
    this.description,
    this.isActive,
    this.createdById,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.items,
  });

  @override
  List<Object?> get props {
    return [
      id,
      templateCode,
      name,
      isActive,
      description,
      createdById,
      createdAt,
      updatedAt,
      createdBy,
      items,
    ];
  }

  PreparationTemplate copyWith({
    int? id,
    String? templateCode,
    String? name,
    String? description,
    int? isActive,
    int? createdById,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    List<PreparationTemplateItem>? items,
  }) {
    return PreparationTemplate(
      id: id ?? this.id,
      templateCode: templateCode ?? this.templateCode,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdById: createdById ?? this.createdById,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      items: items ?? this.items,
    );
  }
}
