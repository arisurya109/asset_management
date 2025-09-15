// ignore_for_file: must_be_immutable

part of 'asset_preparation_detail_bloc.dart';

enum StatusPreparationDetail { initial, loading, success, failed }

class AssetPreparationDetailState extends Equatable {
  StatusPreparationDetail? status;
  List<AssetPreparationDetail>? preparations;
  String? message;

  AssetPreparationDetailState({
    this.status = StatusPreparationDetail.initial,
    this.preparations,
    this.message,
  });

  AssetPreparationDetailState copyWith({
    StatusPreparationDetail? status,
    List<AssetPreparationDetail>? preparations,
    String? message,
  }) {
    return AssetPreparationDetailState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, preparations, message];
}
