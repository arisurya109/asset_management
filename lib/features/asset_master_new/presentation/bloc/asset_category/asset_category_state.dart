// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'asset_category_bloc.dart';

enum StatusAssetCategory { initial, loading, failed, success }

class AssetCategoryState extends Equatable {
  StatusAssetCategory? status;
  List<AssetCategory>? assetCategories;
  AssetCategory? assetCategory;
  String? message;

  AssetCategoryState({
    this.status = StatusAssetCategory.initial,
    this.assetCategories,
    this.assetCategory,
    this.message,
  });

  AssetCategoryState copyWith({
    StatusAssetCategory? status,
    List<AssetCategory>? assetCategories,
    AssetCategory? assetCategory,
    String? message,
  }) {
    return AssetCategoryState(
      status: status ?? this.status,
      assetCategories: assetCategories ?? this.assetCategories,
      assetCategory: assetCategory ?? this.assetCategory,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assetCategories, assetCategory, message];
}
