// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'return_bloc.dart';

enum StatusReturn { initial, loading, failure, success }

// ignore: must_be_immutable
class ReturnState extends Equatable {
  StatusReturn? status;
  String? message;

  ReturnState({this.status = StatusReturn.initial, this.message});

  @override
  List<Object?> get props => [status, message];

  ReturnState copyWith({StatusReturn? status, String? message}) {
    return ReturnState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
