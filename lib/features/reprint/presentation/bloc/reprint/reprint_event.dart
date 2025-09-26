part of 'reprint_bloc.dart';

class ReprintEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnReprintAssetIdNormal extends ReprintEvent {
  final String params;

  OnReprintAssetIdNormal(this.params);
}

class OnReprintAssetIdLarge extends ReprintEvent {
  final String params;

  OnReprintAssetIdLarge(this.params);
}

class OnReprintLocation extends ReprintEvent {
  final String params;

  OnReprintLocation(this.params);
}

class OnSetStatusInitial extends ReprintEvent {}
