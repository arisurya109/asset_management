part of 'asset_model_bloc.dart';

class AssetModelEvent extends Equatable {
  const AssetModelEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAssetModel extends AssetModelEvent {
  final AssetModel params;

  const OnCreateAssetModel(this.params);
}

class OnGetAllAssetModel extends AssetModelEvent {}
