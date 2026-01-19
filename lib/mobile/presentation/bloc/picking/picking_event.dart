part of 'picking_bloc.dart';

class PickingEvent extends Equatable {
  const PickingEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllPickingTaskEvent extends PickingEvent {}

class OnUpdateStatusPickingEvent extends PickingEvent {
  final PickingRequest params;

  const OnUpdateStatusPickingEvent({required this.params});
}
