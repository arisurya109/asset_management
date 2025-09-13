part of 'asset_count_bloc.dart';

// ignore: must_be_immutable
class AssetCountState extends Equatable {
  StatusAssetCount? status;
  List<AssetCount>? assetsCount;
  AssetCount? assetCountDetail;
  String? message;

  AssetCountState({
    this.status,
    this.assetsCount,
    this.assetCountDetail,
    this.message,
  });

  AssetCountState copyWith({
    StatusAssetCount? status = StatusAssetCount.initial,
    List<AssetCount>? assetsCount,
    AssetCount? assetCountDetail,
    String? message,
  }) {
    return AssetCountState(
      status: status ?? this.status,
      assetsCount: assetsCount ?? this.assetsCount,
      assetCountDetail: assetCountDetail ?? this.assetCountDetail,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assetsCount, assetCountDetail, message];
}
