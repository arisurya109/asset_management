// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'location_bloc.dart';

enum StatusLocation { initial, loading, failed, success }

class LocationState extends Equatable {
  StatusLocation? status;
  List<Location>? locations;
  String? message;

  LocationState({
    this.status = StatusLocation.initial,
    this.locations,
    this.message,
  });

  @override
  List<Object?> get props => [status, locations, message];

  LocationState copyWith({
    StatusLocation? status,
    List<Location>? locations,
    String? message,
  }) {
    return LocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      message: message ?? this.message,
    );
  }
}
