// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_desktop_bloc.dart';

enum StatusLocationDesktop { initial, loading, failure, loaded, success }

// ignore: must_be_immutable
class LocationDesktopState extends Equatable {
  StatusLocationDesktop? status;
  LocationPagination? response;
  String? message;

  LocationDesktopState({
    this.status = StatusLocationDesktop.initial,
    this.response,
    this.message,
  });

  @override
  List<Object?> get props => [status, response, message];

  LocationDesktopState copyWith({
    StatusLocationDesktop? status,
    LocationPagination? response,
    String? message,
  }) {
    return LocationDesktopState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
