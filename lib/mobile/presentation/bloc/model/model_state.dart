// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'model_bloc.dart';

enum StatusModel { initial, loading, failure, success }

class ModelState extends Equatable {
  StatusModel? status;
  List<AssetModel>? models;
  String? message;

  ModelState({this.status = StatusModel.initial, this.models, this.message});

  @override
  List<Object?> get props => [status, models, message];

  ModelState copyWith({
    StatusModel? status,
    bool clearAll = false,
    List<AssetModel>? models,
    String? message,
  }) {
    return ModelState(
      status: status ?? this.status,
      models: clearAll ? null : (models ?? this.models),
      message: message ?? this.message,
    );
  }
}
