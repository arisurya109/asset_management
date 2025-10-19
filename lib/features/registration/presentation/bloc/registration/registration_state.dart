// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

enum StatusRegistration { initial, loading, failed, success }

// ignore: must_be_immutable
class RegistrationState extends Equatable {
  StatusRegistration? status;
  String? response;
  String? message;

  RegistrationState({this.status, this.response, this.message});

  @override
  List<Object?> get props => [status, response, message];

  RegistrationState copyWith({
    StatusRegistration? status,
    String? response,
    String? message,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
