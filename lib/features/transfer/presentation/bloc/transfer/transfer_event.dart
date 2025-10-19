part of 'transfer_bloc.dart';

class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class OnTransferAsset extends TransferEvent {
  final Transfer params;

  const OnTransferAsset(this.params);
}
