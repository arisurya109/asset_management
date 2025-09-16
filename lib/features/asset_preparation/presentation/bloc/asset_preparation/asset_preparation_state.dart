// ignore_for_file: must_be_immutable

part of 'asset_preparation_bloc.dart';

enum StatusPreparation {
  initial,
  loading,
  updated,
  created,
  loaded,
  failed,
  exported,
}

class AssetPreparationState extends Equatable {
  StatusPreparation? status;
  List<AssetPreparation>? preparations;
  AssetPreparation? preparation;
  String? message;

  AssetPreparationState({
    this.status = StatusPreparation.initial,
    this.preparations,
    this.preparation,
    this.message,
  });

  AssetPreparationState copyWith({
    StatusPreparation? status,
    List<AssetPreparation>? preparations,
    AssetPreparation? preparation,
    String? message,
  }) {
    return AssetPreparationState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      preparation: preparation ?? this.preparation,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, preparations, preparation, message];
}
