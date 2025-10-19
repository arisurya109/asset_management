// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transfer_bloc.dart';

enum StatusTransfer { initial, loading, failed, success }

// ignore: must_be_immutable
class TransferState extends Equatable {
  StatusTransfer? status;
  String? response;
  String? message;

  TransferState({
    this.status = StatusTransfer.initial,
    this.response,
    this.message,
  });

  @override
  List<Object?> get props => [status, response, message];

  TransferState copyWith({
    StatusTransfer? status,
    String? response,
    String? message,
  }) {
    return TransferState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
