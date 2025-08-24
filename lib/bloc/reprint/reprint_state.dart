// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'reprint_bloc.dart';

class ReprintState extends Equatable {
  StatusReprint? status;
  String? message;

  ReprintState({this.status = StatusReprint.initial, this.message});

  ReprintState copyWith({StatusReprint? status, String? message}) {
    return ReprintState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
