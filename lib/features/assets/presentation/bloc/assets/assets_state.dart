// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'assets_bloc.dart';

enum StatusAssets { initial, loading, failed, success, filtered }

// ignore: must_be_immutable
class AssetsState extends Equatable {
  StatusAssets? status;
  List<AssetsEntity>? assets;
  List<AssetsEntity>? filteredAssets;
  String? message;

  AssetsState({
    this.status = StatusAssets.initial,
    this.assets,
    this.filteredAssets,
    this.message,
  });

  @override
  List<Object?> get props => [status, assets, filteredAssets, message];

  AssetsState copyWith({
    StatusAssets? status,
    List<AssetsEntity>? assets,
    List<AssetsEntity>? filteredAssets,
    String? message,
  }) {
    return AssetsState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      filteredAssets: filteredAssets ?? this.filteredAssets,
      message: message ?? this.message,
    );
  }
}
