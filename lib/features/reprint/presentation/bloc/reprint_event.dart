part of 'reprint_bloc.dart';

class ReprintEvent extends Equatable {
  const ReprintEvent();

  @override
  List<Object?> get props => [];
}

class OnReprintAssetById extends ReprintEvent {
  final String assetId;

  const OnReprintAssetById(this.assetId);
}

class OnReprintAssetBySerialNumber extends ReprintEvent {
  final String serialNumber;

  const OnReprintAssetBySerialNumber(this.serialNumber);
}

class OnReprintLocation extends ReprintEvent {
  final String location;

  const OnReprintLocation(this.location);
}
