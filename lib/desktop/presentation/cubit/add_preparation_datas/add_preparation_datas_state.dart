// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_preparation_datas_cubit.dart';

// ignore: must_be_immutable
class AddPreparationDatasState extends Equatable {
  List<Location>? locations;
  List<User>? workers;
  List<User>? approveds;
  List<AssetModel>? assets;
  List<AssetModel>? assetModels;
  List<String>? assetTypes;
  List<String>? assetCategories;

  AddPreparationDatasState({
    this.locations,
    this.workers,
    this.approveds,
    this.assets,
    this.assetModels,
    this.assetTypes,
    this.assetCategories,
  });

  @override
  List<Object?> get props => [
    locations,
    workers,
    approveds,
    assets,
    assetModels,
    assetTypes,
    assetCategories,
  ];

  AddPreparationDatasState copyWith({
    List<Location>? locations,
    List<User>? workers,
    List<User>? approveds,
    List<AssetModel>? assets,
    List<AssetModel>? assetModels,
    List<String>? assetTypes,
    List<String>? assetCategories,
  }) {
    return AddPreparationDatasState(
      locations: locations ?? this.locations,
      workers: workers ?? this.workers,
      approveds: approveds ?? this.approveds,
      assets: assets ?? this.assets,
      assetTypes: assetTypes ?? this.assetTypes,
      assetCategories: assetCategories ?? this.assetCategories,
      assetModels: assetModels ?? this.assetModels,
    );
  }
}
