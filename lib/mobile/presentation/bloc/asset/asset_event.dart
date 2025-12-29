// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_bloc.dart';

class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAssetsEvent extends AssetEvent {
  final AssetEntity params;

  const OnCreateAssetsEvent(this.params);
}

class OnFindAllAssetEvent extends AssetEvent {}

class OnFindAssetDetailEvent extends AssetEvent {
  final int params;

  const OnFindAssetDetailEvent(this.params);
}

class OnCreateAssetTransferEvent extends AssetEvent {
  final int assetId;
  final String movementType;
  final int fromLocationId;
  final int toLocationId;
  final int? quantity;
  final String? notes;

  const OnCreateAssetTransferEvent({
    required this.assetId,
    required this.movementType,
    required this.fromLocationId,
    required this.toLocationId,
    this.quantity = 1,
    this.notes,
  });
}
