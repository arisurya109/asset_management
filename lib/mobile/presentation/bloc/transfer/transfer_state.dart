// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transfer_bloc.dart';

enum StatusTransfer { initial, loading, failure, loaded, success }

// ignore: must_be_immutable
class TransferState extends Equatable {
  StatusTransfer? status;
  AssetEntity? asset;
  String? message;

  TransferState({
    this.status = StatusTransfer.initial,
    this.asset,
    this.message,
  });

  @override
  List<Object?> get props => [status, asset, message];

  TransferState copyWith({
    StatusTransfer? status,
    AssetEntity? asset,
    String? message,
  }) {
    return TransferState(
      status: status ?? this.status,
      asset: asset ?? this.asset,
      message: message ?? this.message,
    );
  }
}
