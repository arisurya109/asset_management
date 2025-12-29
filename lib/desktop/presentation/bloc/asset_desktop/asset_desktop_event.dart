part of 'asset_desktop_bloc.dart';

class AssetDesktopEvent extends Equatable {
  const AssetDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllAssets extends AssetDesktopEvent {}

class OnFindAssetsByQuery extends AssetDesktopEvent {
  final String params;

  const OnFindAssetsByQuery(this.params);
}
