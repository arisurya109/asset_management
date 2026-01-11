// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_detail_desktop_bloc.dart';

enum StatusAssetDetailDesktop { initial, loading, failure, loaded }

// ignore: must_be_immutable
class AssetDetailDesktopState extends Equatable {
  StatusAssetDetailDesktop? status;
  AssetDetailResponse? response;
  String? message;

  AssetDetailDesktopState({
    this.status = StatusAssetDetailDesktop.initial,
    this.response,
    this.message,
  });

  AssetDetailDesktopState copyWith({
    StatusAssetDetailDesktop? status,
    AssetDetailResponse? response,
    String? message,
  }) {
    return AssetDetailDesktopState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, response, message];
}
