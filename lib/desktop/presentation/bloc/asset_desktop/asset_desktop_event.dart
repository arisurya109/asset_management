part of 'asset_desktop_bloc.dart';

class AssetDesktopEvent extends Equatable {
  const AssetDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindAssetPagination extends AssetDesktopEvent {
  final int? limit;
  final int? page;
  final String? query;

  const OnFindAssetPagination({this.limit, this.page, this.query});
}
