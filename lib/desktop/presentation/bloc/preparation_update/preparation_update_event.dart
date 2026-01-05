part of 'preparation_update_bloc.dart';

class PreparationUpdateEvent extends Equatable {
  const PreparationUpdateEvent();

  @override
  List<Object> get props => [];
}

class OnPreparationUpdate extends PreparationUpdateEvent {
  final Movement params;

  const OnPreparationUpdate(this.params);
}
