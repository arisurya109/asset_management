// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_cubit.dart';

enum StatusRegistration { initial, loading, failure, success }

// ignore: must_be_immutable
class RegistrationState extends Equatable {
  StatusRegistration? status;
  AssetEntity? asset;
  String? message;

  RegistrationState({
    this.status = StatusRegistration.initial,
    this.asset,
    this.message,
  });

  @override
  List<Object?> get props => [status, asset, message];

  RegistrationState copyWith({
    StatusRegistration? status,
    AssetEntity? asset,
    String? message,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      asset: asset ?? this.asset,
      message: message ?? this.message,
    );
  }
}
