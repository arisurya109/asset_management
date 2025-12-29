// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_desktop_bloc.dart';

enum StatusAssetDesktop { initial, loading, failure, loaded }

// ignore: must_be_immutable
class AssetDesktopState extends Equatable {
  StatusAssetDesktop? status;
  List<AssetEntity>? assets;
  String? message;

  AssetDesktopState({
    this.status = StatusAssetDesktop.initial,
    this.assets,
    this.message,
  });

  @override
  List<Object?> get props => [status, assets, message];

  AssetDesktopState copyWith({
    StatusAssetDesktop? status,
    List<AssetEntity>? assets,
    String? message,
  }) {
    return AssetDesktopState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      message: message ?? this.message,
    );
  }
}
