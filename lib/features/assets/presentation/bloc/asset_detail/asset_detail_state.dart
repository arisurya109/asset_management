// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_detail_bloc.dart';

enum StatusAssetDetail { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetDetailState extends Equatable {
  StatusAssetDetail? status;
  List<AssetDetail>? assetDetail;
  String? message;

  AssetDetailState({
    this.status = StatusAssetDetail.initial,
    this.assetDetail,
    this.message,
  });

  @override
  List<Object?> get props => [status, assetDetail, message];

  AssetDetailState copyWith({
    StatusAssetDetail? status,
    List<AssetDetail>? assetDetail,
    String? message,
  }) {
    return AssetDetailState(
      status: status ?? this.status,
      assetDetail: assetDetail ?? this.assetDetail,
      message: message ?? this.message,
    );
  }
}
