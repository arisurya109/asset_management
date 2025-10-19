// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_model_bloc.dart';

enum StatusAssetModel { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetModelState extends Equatable {
  StatusAssetModel? status;
  List<AssetModel>? assets;
  String? message;

  AssetModelState({
    this.status = StatusAssetModel.initial,
    this.assets,
    this.message,
  });

  @override
  List<Object?> get props => [status, assets, message];

  AssetModelState copyWith({
    StatusAssetModel? status,
    List<AssetModel>? assets,
    String? message,
  }) {
    return AssetModelState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      message: message ?? this.message,
    );
  }
}
