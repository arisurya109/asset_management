part of 'preparation_bloc.dart';

class PreparationEvent extends Equatable {
  const PreparationEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePreparationEvent extends PreparationEvent {
  final Preparation params;
  final List<PreparationDetail> preparationDetail;

  const OnCreatePreparationEvent(this.params, this.preparationDetail);
}

class OnFindAllPreparationEvent extends PreparationEvent {}

class OnFindPreparationByIdEvent extends PreparationEvent {
  final int params;

  const OnFindPreparationByIdEvent(this.params);
}

class OnUpdatePreparationEvent extends PreparationEvent {
  final Preparation params;

  const OnUpdatePreparationEvent(this.params);
}

class OnCreatePreparationDetailEvent extends PreparationEvent {
  final PreparationDetail params;

  const OnCreatePreparationDetailEvent(this.params);
}

class OnFindAllPrepartionDetailByPreparationId extends PreparationEvent {
  final int params;

  const OnFindAllPrepartionDetailByPreparationId(this.params);
}

class OnUpdatePreparationDetailEvent extends PreparationEvent {
  final PreparationDetail params;

  const OnUpdatePreparationDetailEvent(this.params);
}

class OnFindPreparationDetailByIdEvent extends PreparationEvent {
  final int params;
  final int preparationId;

  const OnFindPreparationDetailByIdEvent({
    required this.params,
    required this.preparationId,
  });
}
