// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'master_bloc.dart';

enum StatusMaster { initial, loading, failed, success }

// ignore: must_be_immutable
class MasterState extends Equatable {
  StatusMaster? status;
  List<AssetBrand>? brands;
  List<AssetCategory>? categories;
  List<AssetModel>? models;
  List<AssetType>? types;
  List<Location>? locations;
  List<Vendor>? vendors;
  List<PreparationTemplate>? preparationTemplates;
  List<PreparationTemplateItem>? preparationTemplateItems;
  String? message;

  MasterState({
    this.status = StatusMaster.initial,
    this.brands,
    this.categories,
    this.models,
    this.types,
    this.locations,
    this.vendors,
    this.preparationTemplates,
    this.preparationTemplateItems,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    brands,
    categories,
    models,
    types,
    locations,
    vendors,
    preparationTemplates,
    preparationTemplateItems,
    message,
  ];

  MasterState copyWith({
    StatusMaster? status,
    List<AssetBrand>? brands,
    List<AssetCategory>? categories,
    List<AssetModel>? models,
    List<AssetType>? types,
    List<Location>? locations,
    List<Vendor>? vendors,
    List<PreparationTemplate>? preparationTemplates,
    List<PreparationTemplateItem>? preparationTemplateItems,
    String? message,
  }) {
    return MasterState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      categories: categories ?? this.categories,
      models: models ?? this.models,
      types: types ?? this.types,
      locations: locations ?? this.locations,
      vendors: vendors ?? this.vendors,
      preparationTemplates: preparationTemplates ?? this.preparationTemplates,
      preparationTemplateItems:
          preparationTemplateItems ?? this.preparationTemplateItems,
      message: message ?? this.message,
    );
  }
}
