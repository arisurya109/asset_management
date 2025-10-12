part of 'asset_model_bloc.dart';

class AssetModelEvent extends Equatable {
  const AssetModelEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllAssetModel extends AssetModelEvent {}

class OnGetAssetModelById extends AssetModelEvent {
  final int params;

  const OnGetAssetModelById(this.params);
}

class OnCreateAssetModel extends AssetModelEvent {
  final AssetModel params;

  const OnCreateAssetModel(this.params);
}

class OnUpdateAssetModel extends AssetModelEvent {
  final AssetModel params;

  const OnUpdateAssetModel(this.params);
}
