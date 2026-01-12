part of 'picking_bloc.dart';

class PickingEvent extends Equatable {
  const PickingEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllPickingTaskEvent extends PickingEvent {}

class OnUpdateStatusPickingEvent extends PickingEvent {
  final int id;
  final String params;
  final int? locationId;

  const OnUpdateStatusPickingEvent({
    required this.id,
    required this.params,
    this.locationId,
  });
}
