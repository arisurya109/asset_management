// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_bloc.dart';

enum StatusPreparation { initial, loading, failed, success }

// ignore: must_be_immutable
class PreparationState extends Equatable {
  StatusPreparation? status;
  List<Preparation>? preparations;
  Preparation? preparation;
  String? message;

  PreparationState({
    this.status = StatusPreparation.initial,
    this.preparations,
    this.preparation,
    this.message,
  });

  @override
  List<Object?> get props => [status, preparations, preparation, message];

  PreparationState copyWith({
    StatusPreparation? status,
    List<Preparation>? preparations,
    Preparation? preparation,
    String? message,
  }) {
    return PreparationState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      preparation: preparation ?? this.preparation,
      message: message ?? this.message,
    );
  }
}
