part of 'asset_count_detail_bloc.dart';

class AssetCountDetailEvent extends Equatable {
  const AssetCountDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnCreateAssetCountDetail extends AssetCountDetailEvent {
  final AssetCountDetail params;

  const OnCreateAssetCountDetail(this.params);
}

class OnDeleteAssetCountDetail extends AssetCountDetailEvent {
  final int countId;
  final String params;

  const OnDeleteAssetCountDetail(this.countId, this.params);
}

class OnGetAllAssetCountDetailById extends AssetCountDetailEvent {
  final int params;

  const OnGetAllAssetCountDetailById(this.params);
}
