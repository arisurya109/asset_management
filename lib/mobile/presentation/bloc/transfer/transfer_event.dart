part of 'transfer_bloc.dart';

class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class OnGetAssetByAssetCode extends TransferEvent {
  final String params;

  const OnGetAssetByAssetCode(this.params);
}

class OnTransferAsset extends TransferEvent {
  final Movement params;

  const OnTransferAsset(this.params);
}
