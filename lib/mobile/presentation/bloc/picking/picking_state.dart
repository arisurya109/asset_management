// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'picking_bloc.dart';

enum StatusPicking { initial, loading, failure, loaded, updateSuccess }

// ignore: must_be_immutable
class PickingState extends Equatable {
  StatusPicking? status;
  List<Picking>? picking;
  String? message;

  PickingState({
    this.status = StatusPicking.initial,
    this.picking,
    this.message,
  });

  @override
  List<Object?> get props => [status, picking, message];

  PickingState copyWith({
    StatusPicking? status,
    List<Picking>? picking,
    String? message,
  }) {
    return PickingState(
      status: status ?? this.status,
      picking: picking ?? this.picking,
      message: message ?? this.message,
    );
  }
}
