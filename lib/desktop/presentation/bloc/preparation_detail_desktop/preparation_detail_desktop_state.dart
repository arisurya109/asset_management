// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_detail_desktop_bloc.dart';

enum StatusPreparationDetailDesktop {
  initial,
  loading,
  failure,
  loaded,
  addSuccess,
  deleteSuccess,
}

// ignore: must_be_immutable
class PreparationDetailDesktopState extends Equatable {
  StatusPreparationDetailDesktop? status;
  PreparationDetailResponse? preparationDetails;
  String? message;

  PreparationDetailDesktopState({
    this.status = StatusPreparationDetailDesktop.initial,
    this.preparationDetails,
    this.message,
  });

  @override
  List<Object?> get props => [status, preparationDetails, message];

  PreparationDetailDesktopState copyWith({
    StatusPreparationDetailDesktop? status,
    PreparationDetailResponse? preparationDetails,
    String? message,
  }) {
    return PreparationDetailDesktopState(
      status: status ?? this.status,
      preparationDetails: preparationDetails ?? this.preparationDetails,
      message: message ?? this.message,
    );
  }
}
