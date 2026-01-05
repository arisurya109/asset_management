part of 'asset_bloc.dart';

class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class OnFindAssetByQuery extends AssetEvent {
  final String params;

  const OnFindAssetByQuery(this.params);
}

class OnClearAll extends AssetEvent {}
