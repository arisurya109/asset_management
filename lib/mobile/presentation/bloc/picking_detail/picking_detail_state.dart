// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'picking_detail_bloc.dart';

enum StatusPickingDetail { initial, loading, failure, loaded, addSuccess }

// ignore: must_be_immutable
class PickingDetailState extends Equatable {
  StatusPickingDetail? status;
  PickingDetailResponse? response;
  String? message;

  PickingDetailState({
    this.status = StatusPickingDetail.initial,
    this.response,
    this.message,
  });

  @override
  List<Object?> get props => [status, response, message];

  PickingDetailState copyWith({
    StatusPickingDetail? status,
    PickingDetailResponse? response,
    String? message,
  }) {
    return PickingDetailState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
