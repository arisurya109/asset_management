// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_bloc.dart';

enum StatusAsset { initial, loading, failure, success }

// ignore: must_be_immutable
class AssetState extends Equatable {
  StatusAsset? status;
  List<AssetEntity>? assets;
  String? message;

  AssetState({this.status = StatusAsset.initial, this.assets, this.message});

  @override
  List<Object?> get props => [status, assets, message];

  AssetState copyWith({
    StatusAsset? status,
    List<AssetEntity>? assets,
    bool clearAll = false,
    String? message,
  }) {
    return AssetState(
      status: status ?? this.status,
      assets: clearAll ? null : (assets ?? this.assets),
      message: message ?? this.message,
    );
  }
}
