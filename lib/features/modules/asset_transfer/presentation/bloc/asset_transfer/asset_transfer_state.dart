// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_transfer_bloc.dart';

enum StatusAssetTransfer { initial, loading, failed, success }

// ignore: must_be_immutable
class AssetTransferState extends Equatable {
  StatusAssetTransfer? status;
  String? messageFailed;
  String? messageSuccess;

  AssetTransferState({
    this.status = StatusAssetTransfer.initial,
    this.messageFailed,
    this.messageSuccess,
  });

  @override
  List<Object?> get props => [status, messageFailed, messageSuccess];

  AssetTransferState copyWith({
    StatusAssetTransfer? status,
    String? messageFailed,
    String? messageSuccess,
  }) {
    return AssetTransferState(
      status: status ?? this.status,
      messageFailed: messageFailed ?? this.messageFailed,
      messageSuccess: messageSuccess ?? this.messageSuccess,
    );
  }
}
