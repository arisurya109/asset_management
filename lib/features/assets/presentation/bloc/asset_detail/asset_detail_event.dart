part of 'asset_detail_bloc.dart';

class AssetDetailEvent extends Equatable {
  const AssetDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetAssetDetailById extends AssetDetailEvent {
  final int params;

  const OnGetAssetDetailById(this.params);
}
