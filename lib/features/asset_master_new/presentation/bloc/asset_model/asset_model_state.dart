// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_model_bloc.dart';

enum StatusAssetModel { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetModelState extends Equatable {
  StatusAssetModel? status;
  List<AssetModel>? assetModels;
  AssetModel? assetModel;
  String? message;

  AssetModelState({
    this.status = StatusAssetModel.initial,
    this.assetModels,
    this.assetModel,
    this.message,
  });

  AssetModelState copyWith({
    StatusAssetModel? status,
    List<AssetModel>? assetModels,
    AssetModel? assetModel,
    String? message,
  }) {
    return AssetModelState(
      status: status ?? this.status,
      assetModels: assetModels ?? this.assetModels,
      assetModel: assetModel ?? this.assetModel,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assetModels, assetModel, message];
}
