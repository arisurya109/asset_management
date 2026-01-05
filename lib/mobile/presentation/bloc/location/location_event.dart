part of 'location_bloc.dart';

class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnCreateLocationEvent extends LocationEvent {
  final Location params;

  const OnCreateLocationEvent(this.params);
}

class OnFindLocationByQuery extends LocationEvent {
  final String params;

  const OnFindLocationByQuery(this.params);
}

class OnClearAll extends LocationEvent {}
