// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_brand_bloc.dart';

enum StatusAssetBrand { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetBrandState extends Equatable {
  StatusAssetBrand? status;
  List<AssetBrand>? brands;
  String? message;

  AssetBrandState({
    this.status = StatusAssetBrand.initial,
    this.brands,
    this.message,
  });

  @override
  List<Object?> get props => [status, brands, message];

  AssetBrandState copyWith({
    StatusAssetBrand? status,
    List<AssetBrand>? brands,
    String? message,
  }) {
    return AssetBrandState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      message: message ?? this.message,
    );
  }
}
