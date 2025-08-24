part of 'reprint_bloc.dart';

sealed class ReprintEvent extends Equatable {
  const ReprintEvent();

  @override
  List<Object> get props => [];
}

class OnReprintAssetIdByAssetId extends ReprintEvent {
  final String assetId;

  const OnReprintAssetIdByAssetId(this.assetId);
}

class OnReprintLocation extends ReprintEvent {
  final String location;

  const OnReprintLocation(this.location);
}

class OnSetStatusInitial extends ReprintEvent {}
