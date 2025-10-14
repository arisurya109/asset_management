part of 'asset_registration_bloc.dart';

class AssetRegistrationEvent extends Equatable {
  const AssetRegistrationEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAsset extends AssetRegistrationEvent {
  final AssetRegistration params;

  const OnCreateAsset(this.params);
}

class OnCreateAssetConsumable extends AssetRegistrationEvent {
  final AssetRegistration params;

  const OnCreateAssetConsumable(this.params);
}

class OnFindAllAssetRegistration extends AssetRegistrationEvent {}

class OnMigrationAsset extends AssetRegistrationEvent {
  final AssetRegistration params;

  const OnMigrationAsset(this.params);
}
