// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_desktop_bloc.dart';

enum StatusAssetDesktop { initial, loading, failure, loaded }

// ignore: must_be_immutable
class AssetDesktopState extends Equatable {
  StatusAssetDesktop? status;
  AssetEntityPagination? response;
  String? message;

  AssetDesktopState({
    this.status = StatusAssetDesktop.initial,
    this.response,
    this.message,
  });

  @override
  List<Object?> get props => [status, response, message];

  AssetDesktopState copyWith({
    StatusAssetDesktop? status,
    AssetEntityPagination? response,
    String? message,
  }) {
    return AssetDesktopState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
