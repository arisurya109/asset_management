part of 'asset_detail_desktop_bloc.dart';

class AssetDetailDesktopEvent extends Equatable {
  const AssetDetailDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnGetAssetDetailEvent extends AssetDetailDesktopEvent {
  final int params;

  const OnGetAssetDetailEvent(this.params);
}
