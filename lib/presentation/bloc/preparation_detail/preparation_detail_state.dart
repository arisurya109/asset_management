// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_detail_bloc.dart';

enum StatusPreparationDetail { initial, loading, failed, success }

// ignore: must_be_immutable
class PreparationDetailState extends Equatable {
  StatusPreparationDetail? status;
  List<PreparationDetail>? preparationDetails;
  PreparationDetail? preparationDetail;
  String? message;

  PreparationDetailState({
    this.status = StatusPreparationDetail.initial,
    this.preparationDetails,
    this.preparationDetail,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    preparationDetails,
    preparationDetail,
    message,
  ];

  PreparationDetailState copyWith({
    StatusPreparationDetail? status,
    List<PreparationDetail>? preparationDetails,
    PreparationDetail? preparationDetail,
    String? message,
  }) {
    return PreparationDetailState(
      status: status ?? this.status,
      preparationDetails: preparationDetails ?? this.preparationDetails,
      preparationDetail: preparationDetail ?? this.preparationDetail,
      message: message ?? this.message,
    );
  }
}
