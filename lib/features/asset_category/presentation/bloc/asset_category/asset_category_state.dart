// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_category_bloc.dart';

enum StatusAssetCategory { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetCategoryState extends Equatable {
  StatusAssetCategory? status;
  List<AssetCategory>? category;
  String? message;

  AssetCategoryState({
    this.status = StatusAssetCategory.initial,
    this.category,
    this.message,
  });

  @override
  List<Object?> get props => [status, category, message];

  AssetCategoryState copyWith({
    StatusAssetCategory? status,
    List<AssetCategory>? category,
    String? message,
  }) {
    return AssetCategoryState(
      status: status ?? this.status,
      category: category ?? this.category,
      message: message ?? this.message,
    );
  }
}
