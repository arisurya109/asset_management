import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class PreparationTemplateItem extends Equatable {
  int? id;
  int? templateId;
  int? modelId;
  int? quantity;
  String? notes;
  String? assetType;
  String? assetBrand;
  String? assetCategory;
  String? assetModel;

  PreparationTemplateItem({
    this.id,
    this.templateId,
    this.modelId,
    this.quantity,
    this.notes,
    this.assetType,
    this.assetBrand,
    this.assetCategory,
    this.assetModel,
  });

  @override
  List<Object?> get props {
    return [
      id,
      templateId,
      modelId,
      quantity,
      notes,
      assetType,
      assetBrand,
      assetCategory,
      assetModel,
    ];
  }

  PreparationTemplateItem copyWith({
    int? id,
    int? templateId,
    int? modelId,
    int? quantity,
    String? notes,
    String? assetType,
    String? assetBrand,
    String? assetCategory,
    String? assetModel,
  }) {
    return PreparationTemplateItem(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      modelId: modelId ?? this.modelId,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
      assetType: assetType ?? this.assetType,
      assetBrand: assetBrand ?? this.assetBrand,
      assetCategory: assetCategory ?? this.assetCategory,
      assetModel: assetModel ?? this.assetModel,
    );
  }
}
