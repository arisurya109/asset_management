// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_desktop_bloc.dart';

enum StatusPreparationDesktop { initial, loading, failure, loaded, addSuccess }

// ignore: must_be_immutable
class PreparationDesktopState extends Equatable {
  StatusPreparationDesktop? status;
  PreparationPagination? datas;
  String? message;

  PreparationDesktopState({
    this.status = StatusPreparationDesktop.initial,
    this.datas,
    this.message,
  });

  @override
  List<Object?> get props => [status, datas, message];

  PreparationDesktopState copyWith({
    StatusPreparationDesktop? status,
    PreparationPagination? datas,
    String? message,
  }) {
    return PreparationDesktopState(
      status: status ?? this.status,
      datas: datas ?? this.datas,
      message: message ?? this.message,
    );
  }
}
