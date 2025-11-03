// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_bloc.dart';

enum StatusPreparation { initial, loading, failed, success }

// ignore: must_be_immutable
class PreparationState extends Equatable {
  StatusPreparation? status;
  List<Preparation>? preparations;
  Preparation? preparation;
  List<PreparationDetail>? preparationDetails;
  PreparationDetail? preparationDetail;
  String? message;

  PreparationState({
    this.status = StatusPreparation.initial,
    this.preparations,
    this.preparation,
    this.preparationDetails,
    this.preparationDetail,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    preparations,
    preparation,
    preparationDetails,
    preparationDetail,
    message,
  ];

  PreparationState copyWith({
    StatusPreparation? status,
    List<Preparation>? preparations,
    Preparation? preparation,
    List<PreparationDetail>? preparationDetails,
    PreparationDetail? preparationDetail,
    String? message,
  }) {
    return PreparationState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      preparation: preparation ?? this.preparation,
      preparationDetails: preparationDetails ?? this.preparationDetails,
      preparationDetail: preparationDetail ?? this.preparationDetail,
      message: message ?? this.message,
    );
  }
}
