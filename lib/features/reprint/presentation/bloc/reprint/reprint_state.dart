part of 'reprint_bloc.dart';

enum StatusReprint { initial, loading, failed, success }

// ignore: must_be_immutable
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
