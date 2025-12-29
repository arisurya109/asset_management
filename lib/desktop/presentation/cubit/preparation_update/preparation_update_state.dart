// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'preparation_update_cubit.dart';

enum StatusPreparationUpdate { initial, loading, failure, success }

class PreparationUpdateState extends Equatable {
  StatusPreparationUpdate? status;
  String? message;

  PreparationUpdateState({
    this.status = StatusPreparationUpdate.initial,
    this.message,
  });

  @override
  List<Object?> get props => [status, message];

  PreparationUpdateState copyWith({
    StatusPreparationUpdate? status,
    String? message,
  }) {
    return PreparationUpdateState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
