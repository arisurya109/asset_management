// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_registration_bloc.dart';

enum StatusAssetRegistration { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetRegistrationState extends Equatable {
  StatusAssetRegistration? status;
  List<AssetRegistration>? assetsConsumable;
  List<AssetRegistration>? assetNonConsumable;
  String? message;

  AssetRegistrationState({
    this.status = StatusAssetRegistration.initial,
    this.assetsConsumable,
    this.assetNonConsumable,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    assetNonConsumable,
    assetsConsumable,
    message,
  ];

  AssetRegistrationState copyWith({
    StatusAssetRegistration? status,
    List<AssetRegistration>? assetsConsumable,
    List<AssetRegistration>? assetNonCunsumable,
    String? message,
  }) {
    return AssetRegistrationState(
      status: status ?? this.status,
      assetsConsumable: assetsConsumable ?? this.assetsConsumable,
      assetNonConsumable: assetNonCunsumable ?? this.assetNonConsumable,
      message: message ?? this.message,
    );
  }
}
