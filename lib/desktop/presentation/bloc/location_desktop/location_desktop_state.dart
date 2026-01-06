// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_desktop_bloc.dart';

enum StatusLocationDesktop { initial, loading, failure, loaded, success }

// ignore: must_be_immutable
class LocationDesktopState extends Equatable {
  StatusLocationDesktop? status;
  List<Location>? locations;
  String? message;

  LocationDesktopState({
    this.status = StatusLocationDesktop.initial,
    this.locations,
    this.message,
  });

  @override
  List<Object?> get props => [status, locations, message];

  LocationDesktopState copyWith({
    StatusLocationDesktop? status,
    List<Location>? locations,
    String? message,
  }) {
    return LocationDesktopState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      message: message ?? this.message,
    );
  }
}
