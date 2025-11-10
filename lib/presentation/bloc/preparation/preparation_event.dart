part of 'preparation_bloc.dart';

class PreparationEvent extends Equatable {
  const PreparationEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePreparationEvent extends PreparationEvent {
  final Preparation params;

  const OnCreatePreparationEvent(this.params);
}

class OnFindAllPreparationEvent extends PreparationEvent {}

class OnUpdatePreparationEvent extends PreparationEvent {
  final Preparation params;

  const OnUpdatePreparationEvent(this.params);
}

class OnFindPreparationByIdEvent extends PreparationEvent {
  final int params;

  const OnFindPreparationByIdEvent(this.params);
}
