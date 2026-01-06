part of 'location_desktop_bloc.dart';

class LocationDesktopEvent extends Equatable {
  const LocationDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindLocationPagination extends LocationDesktopEvent {
  final int? limit;
  final int? page;
  final String? query;

  const OnFindLocationPagination({this.limit, this.page, this.query});
}

class OnCreateLocationEvent extends LocationDesktopEvent {
  final Location params;

  const OnCreateLocationEvent(this.params);
}
