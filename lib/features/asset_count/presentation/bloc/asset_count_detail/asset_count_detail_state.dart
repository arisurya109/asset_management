// ignore_for_file: must_be_immutable

part of 'asset_count_detail_bloc.dart';

class AssetCountDetailState extends Equatable {
  StatusAssetCountDetail? status;
  List<AssetCountDetail>? assets;
  String? message;

  AssetCountDetailState({this.status, this.assets, this.message});

  AssetCountDetailState copyWith({
    StatusAssetCountDetail? status = StatusAssetCountDetail.initial,
    List<AssetCountDetail>? assets,
    String? message,
  }) {
    return AssetCountDetailState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assets, message];
}
