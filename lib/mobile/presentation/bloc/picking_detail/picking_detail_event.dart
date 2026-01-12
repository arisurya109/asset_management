part of 'picking_detail_bloc.dart';

class PickingDetailEvent extends Equatable {
  const PickingDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetPickingDetailEvent extends PickingDetailEvent {
  final int params;

  const OnGetPickingDetailEvent(this.params);
}

class OnPickAssetEvent extends PickingDetailEvent {
  final int preparationId;
  final PickingDetailItem params;

  const OnPickAssetEvent(this.params, this.preparationId);
}

class OnSetInitialStatus extends PickingDetailEvent {}
