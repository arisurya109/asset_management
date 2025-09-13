part of 'asset_count_bloc.dart';

class AssetCountEvent extends Equatable {
  const AssetCountEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAllAssetCount extends AssetCountEvent {}

class OnCreateAssetCount extends AssetCountEvent {
  final AssetCount params;

  const OnCreateAssetCount(this.params);
}

class OnUpdateStatusAssetCount extends AssetCountEvent {
  final int countId;
  final StatusCount params;

  const OnUpdateStatusAssetCount(this.countId, this.params);
}

class OnExportAssetCount extends AssetCountEvent {
  final int params;

  const OnExportAssetCount(this.params);
}

class OnSelectedAssetCountDetail extends AssetCountEvent {
  final int params;

  const OnSelectedAssetCountDetail(this.params);
}
