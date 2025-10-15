part of 'asset_transfer_bloc.dart';

class AssetTransferEvent extends Equatable {
  const AssetTransferEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAssetTransfer extends AssetTransferEvent {
  final AssetTransfer params;

  const OnCreateAssetTransfer(this.params);
}
