part of 'location_desktop_bloc.dart';

class LocationDesktopEvent extends Equatable {
  const LocationDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllLocation extends LocationDesktopEvent {}

class OnFindAllLocationByQuery extends LocationDesktopEvent {
  final String query;

  const OnFindAllLocationByQuery(this.query);
}

class OnCreateLocationEvent extends LocationDesktopEvent {
  final Location params;

  const OnCreateLocationEvent(this.params);
}
