part of 'location_bloc.dart';

class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllLocation extends LocationEvent {}

class OnCreateLocation extends LocationEvent {
  final Location params;

  const OnCreateLocation(this.params);
}
