// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_type_bloc.dart';

enum StatusAssetType { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetTypeState extends Equatable {
  StatusAssetType? status;
  List<AssetType>? types;
  String? message;

  AssetTypeState({
    this.status = StatusAssetType.initial,
    this.types,
    this.message,
  });

  @override
  List<Object?> get props => [status, types, message];

  AssetTypeState copyWith({
    StatusAssetType? status,
    List<AssetType>? types,
    String? message,
  }) {
    return AssetTypeState(
      status: status ?? this.status,
      types: types ?? this.types,
      message: message ?? this.message,
    );
  }
}
