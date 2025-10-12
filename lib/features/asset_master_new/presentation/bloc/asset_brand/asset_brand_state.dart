// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'asset_brand_bloc.dart';

enum StatusAssetBrand { initial, loading, failed, success }

class AssetBrandState extends Equatable {
  StatusAssetBrand? status;
  List<AssetBrand>? assetBrands;
  AssetBrand? assetBrand;
  String? message;

  AssetBrandState({
    this.status = StatusAssetBrand.initial,
    this.assetBrands,
    this.assetBrand,
    this.message,
  });

  AssetBrandState copyWith({
    StatusAssetBrand? status,
    List<AssetBrand>? assetBrands,
    AssetBrand? assetBrand,
    String? message,
  }) {
    return AssetBrandState(
      status: status ?? this.status,
      assetBrands: assetBrands ?? this.assetBrands,
      assetBrand: assetBrand ?? this.assetBrand,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assetBrands, assetBrand, message];
}
