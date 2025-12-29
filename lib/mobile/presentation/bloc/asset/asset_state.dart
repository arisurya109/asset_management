// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_bloc.dart';

enum StatusAsset { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetState extends Equatable {
  StatusAsset? status;
  List<AssetEntity>? assets;
  List<AssetDetail>? assetDetails;
  AssetEntity? response;
  String? message;

  AssetState({
    this.status = StatusAsset.initial,
    this.assets,
    this.assetDetails,
    this.response,
    this.message,
  });

  @override
  List<Object?> get props => [status, assets, assetDetails, message, response];

  AssetState copyWith({
    StatusAsset? status,
    List<AssetEntity>? assets,
    List<AssetDetail>? assetDetails,
    String? message,
    AssetEntity? response,
  }) {
    return AssetState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      assetDetails: assetDetails ?? this.assetDetails,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }
}
