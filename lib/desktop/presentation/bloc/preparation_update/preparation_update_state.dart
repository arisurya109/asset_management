// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_update_bloc.dart';

enum StatusPreparationUpdate { initial, loading, failure, success }

// ignore: must_be_immutable
class PreparationUpdateState extends Equatable {
  StatusPreparationUpdate? status;
  String? message;

  PreparationUpdateState({this.status, this.message});

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
