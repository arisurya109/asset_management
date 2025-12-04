// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_bloc.dart';

enum StatusPreparation {
  initial,
  loading,
  failure,
  loaded,
  createPreparation,
  updatePreparation,
  findItemByPreparationDetailId,
}

// ignore: must_be_immutable
class PreparationState extends Equatable {
  StatusPreparation? status;
  List<Preparation>? preparations;
  Preparation? preparation;
  List<PreparationDetail>? preparationDetails;
  PreparationDetail? preparationDetail;
  List<PreparationItem>? itemsByPreparation;
  List<PreparationItem>? itemByPreparationDetail;
  String? message;

  PreparationState({
    this.status = StatusPreparation.initial,
    this.preparations,
    this.preparation,
    this.preparationDetails,
    this.preparationDetail,
    this.itemsByPreparation,
    this.itemByPreparationDetail,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    preparations,
    preparation,
    preparationDetails,
    preparationDetail,
    itemsByPreparation,
    itemByPreparationDetail,
  ];

  PreparationState copyWith({
    StatusPreparation? status,
    List<Preparation>? preparations,
    Preparation? preparation,
    List<PreparationDetail>? preparationDetails,
    PreparationDetail? preparationDetail,
    List<PreparationItem>? itemsByPreparation,
    List<PreparationItem>? itemByPreparationDetail,
    String? message,
  }) {
    return PreparationState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      preparation: preparation ?? this.preparation,
      preparationDetails: preparationDetails ?? this.preparationDetails,
      preparationDetail: preparationDetail ?? this.preparationDetail,
      itemsByPreparation: itemsByPreparation ?? this.itemsByPreparation,
      itemByPreparationDetail:
          itemByPreparationDetail ?? this.itemByPreparationDetail,
      message: message ?? this.message,
    );
  }
}
