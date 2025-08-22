// ignore_for_file: must_be_immutable

part of 'reprint_bloc.dart';

enum StatusReprint { initial, loading, success, failed }

class ReprintState extends Equatable {
  StatusReprint? status;
  String? message;

  ReprintState({this.status, this.message});

  ReprintState copyWith({
    StatusReprint? status = StatusReprint.initial,
    String? message,
  }) {
    return ReprintState(status: status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
